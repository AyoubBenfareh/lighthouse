import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:noor_quest/l10n/app_localizations.dart';

void main() {
  testWidgets('GoRouter navigates between home and map stubs', (tester) async {
    late final GoRouter router;
    router = GoRouter(
      initialLocation: '/home',
      routes: [
        GoRoute(
          path: '/home',
          builder: (context, state) => Scaffold(
            body: Center(
              child: ElevatedButton(
                onPressed: () => router.go('/map'),
                child: const Text('Open map'),
              ),
            ),
          ),
        ),
        GoRoute(
          path: '/map',
          builder: (context, state) => const Scaffold(
            body: Center(child: Text('Adventure Map')),
          ),
        ),
      ],
    );

    await tester.pumpWidget(
      MaterialApp.router(
        locale: const Locale('en'),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        routerConfig: router,
      ),
    );
    await tester.pump();

    expect(find.text('Open map'), findsOneWidget);
    await tester.tap(find.text('Open map'));
    await tester.pump();
    expect(find.text('Adventure Map'), findsOneWidget);
  });

  test('AppLocalizations supports ar de en with RTL-ready Arabic strings', () async {
    final en = await AppLocalizations.delegate.load(const Locale('en'));
    final ar = await AppLocalizations.delegate.load(const Locale('ar'));
    final de = await AppLocalizations.delegate.load(const Locale('de'));

    expect(en.appTitle, 'Noor Quest');
    expect(ar.appTitle, 'مغامرات نور');
    expect(de.worldMapTitle, isNotEmpty);
    expect(ar.arabicLettersHint, contains('حرف'));
    expect(
      AppLocalizations.supportedLocales.map((l) => l.languageCode),
      containsAll(['ar', 'de', 'en']),
    );
  });
}
