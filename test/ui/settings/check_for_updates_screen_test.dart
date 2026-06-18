/// "Check for updates" screen (ADR 0017).
///
/// Drives the voluntary OTA surface through a fake [ContentUpdateService] so
/// the widget tests never touch the network or the signature/sha verifier
/// (those are covered in test/services/ota/). What we assert here is the UI
/// contract: nothing is contacted until "Check now"; each status renders its
/// own message; "available" offers a second, explicit Apply; and a successful
/// apply offers an in-app "Show the update now" soft restart.
library;

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lighthouse/l10n/app_localizations.dart';
import 'package:lighthouse/services/services.dart';
import 'package:lighthouse/state/state.dart';
import 'package:lighthouse/ui/settings/check_for_updates_screen.dart';

/// A [ContentUpdateService] whose check/apply are canned. The real deps are
/// constructed with inert values (empty config, no dir) and never exercised,
/// because both methods are overridden.
class _FakeUpdateService extends ContentUpdateService {
  _FakeUpdateService(this._check, {this.onApply})
      : super(
          baseUrl: 'https://example.test/content',
          appVersion: '1.0.0',
          httpClient: HttpContentClient(appVersion: '1.0.0'),
          store: ContentOverlayStore(),
          verifier:
              ManifestSignatureVerifier(trustedPublicKeysBase64: const []),
        );

  final UpdateCheck _check;
  final void Function()? onApply;

  /// What [lastCheckedAt] reports. Starts null (never checked) so the widget
  /// tests never touch SharedPreferences; a check() flips it to "now".
  DateTime? lastChecked;

  @override
  Future<UpdateCheck> check() async {
    // Mirror production: a server-reached check records the time locally.
    lastChecked = DateTime.now();
    return _check;
  }

  @override
  Future<void> apply(ContentManifest manifest) async => onApply?.call();

  @override
  Future<DateTime?> lastCheckedAt() async => lastChecked;
}

const _manifest = ContentManifest(
  schemaVersion: 1,
  sequence: 7,
  contentVersion: '2026.05.31',
  files: [],
);

Widget _host(ContentUpdateService service) {
  return ProviderScope(
    overrides: [
      contentUpdateServiceProvider.overrideWith((ref) async => service),
    ],
    child: const MaterialApp(
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [Locale('en')],
      home: CheckForUpdatesScreen(),
    ),
  );
}

void main() {
  testWidgets('does nothing until the parent taps Check now', (tester) async {
    await tester.pumpWidget(
      _host(_FakeUpdateService(const UpdateCheck(UpdateStatus.upToDate))),
    );
    await tester.pumpAndSettle();

    // No status is shown before the explicit tap (voluntary check, ADR 0017).
    expect(find.text('You are up to date.'), findsNothing);
    expect(find.byKey(const ValueKey('ota_check_now')), findsOneWidget);
  });

  testWidgets('up to date shows the up-to-date message', (tester) async {
    await tester.pumpWidget(
      _host(_FakeUpdateService(const UpdateCheck(UpdateStatus.upToDate))),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('ota_check_now')));
    await tester.pumpAndSettle();

    expect(find.text('You are up to date.'), findsOneWidget);
    expect(find.byKey(const ValueKey('ota_apply')), findsNothing);
  });

  testWidgets('available offers Apply, then confirms applied', (tester) async {
    var applied = false;
    await tester.pumpWidget(
      _host(
        _FakeUpdateService(
          const UpdateCheck(UpdateStatus.available, manifest: _manifest),
          onApply: () => applied = true,
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('ota_check_now')));
    await tester.pumpAndSettle();

    // Found, but not yet applied: a second, explicit confirm is required.
    expect(find.text('Corrections are available.'), findsOneWidget);
    expect(applied, isFalse);

    await tester.tap(find.byKey(const ValueKey('ota_apply')));
    await tester.pumpAndSettle();

    expect(applied, isTrue);
    // Applied UI offers an in-app "Show the update now" soft restart (build 7),
    // no manual app-restart instruction. Tapping it is a no-op here (no
    // RestartWidget ancestor in the test host) and must not throw; the re-mount
    // itself is covered in test/ui/widgets/restart_widget_test.dart.
    expect(find.text('Applied.'), findsOneWidget);
    final showNow = find.byKey(const ValueKey('ota_show_now'));
    expect(showNow, findsOneWidget);
    expect(find.textContaining('Restart Lighthouse'), findsNothing);
    await tester.tap(showNow);
    await tester.pumpAndSettle();
  });

  testWidgets('incompatible tells the parent to update the app',
      (tester) async {
    await tester.pumpWidget(
      _host(_FakeUpdateService(const UpdateCheck(UpdateStatus.incompatible))),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('ota_check_now')));
    await tester.pumpAndSettle();

    expect(find.textContaining('newer version of Lighthouse'), findsOneWidget);
  });

  testWidgets('idle shows "never" before any check on this device',
      (tester) async {
    await tester.pumpWidget(
      _host(_FakeUpdateService(const UpdateCheck(UpdateStatus.upToDate))),
    );
    await tester.pumpAndSettle();

    expect(find.text('Last checked: never on this device.'), findsOneWidget);
  });

  testWidgets(
      'after a successful check, re-entering shows the stored time, not "never"',
      (tester) async {
    // P2 regression: the result used to live only in transient widget state, so
    // backing out and re-entering reverted to "never on this device" even right
    // after a successful check. The timestamp now persists in the service.
    final service = _FakeUpdateService(const UpdateCheck(UpdateStatus.upToDate));

    // First entry: nothing checked yet on this device.
    await tester.pumpWidget(_host(service));
    await tester.pumpAndSettle();
    expect(find.text('Last checked: never on this device.'), findsOneWidget);

    // Run a check (server reached -> records the time locally).
    await tester.tap(find.byKey(const ValueKey('ota_check_now')));
    await tester.pumpAndSettle();
    expect(find.text('You are up to date.'), findsOneWidget);

    // Back out (dispose the screen) and re-enter: a fresh screen instance runs
    // initState and reads the stored time. Unmounting first is what makes this
    // a real re-entry; re-pumping the same tree would just reuse the State.
    await tester.pumpWidget(const SizedBox());
    await tester.pumpAndSettle();
    await tester.pumpWidget(_host(service));
    await tester.pumpAndSettle();

    expect(find.text('Last checked: just now'), findsOneWidget);
    expect(find.text('Last checked: never on this device.'), findsNothing);
  });
}
