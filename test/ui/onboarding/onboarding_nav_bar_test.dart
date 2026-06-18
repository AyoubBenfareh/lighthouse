/// Regression: the final onboarding screen's two CTAs ("Take the quick tour" /
/// "Skip, go to the board") shipped truncated as "Ta..." / "Sk..." on Android.
///
/// They were laid out side-by-side in one Row after [Back] and a [Spacer], so
/// the width split three ways and each button got ~1/3 of it; the long labels
/// (longer still in es/ar and at large Dynamic Type) ellipsized to two letters.
/// They are now stacked full-width, primary on top, and wrap instead of clip.
///
/// These tests pin that contract on the narrowest realistic phone width, at a
/// large text scale, in en/es/ar. The nav bar is exercised in isolation with a
/// directly-injected MediaQuery so the assertions are deterministic (no flaky
/// intermediate onboarding screens, no platform text-scale plumbing).
library;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lighthouse/l10n/app_localizations.dart';
import 'package:lighthouse/ui/onboarding/onboarding_flow.dart';

import '../../support/localized.dart';

void main() {
  // Mirror production: the nav bar is the last child of a Column after a
  // flexible region (an Expanded PageView), so it is laid out under loose width
  // constraints and hugs its content height.
  Future<void> pumpNavBar(
    WidgetTester tester, {
    required double width,
    required double textScale,
    Locale? locale,
    bool isLast = true,
  }) async {
    tester.view.physicalSize = Size(width, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(localizedApp(
      Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              const Spacer(),
              Builder(
                builder: (context) => MediaQuery(
                  data: MediaQuery.of(context)
                      .copyWith(textScaler: TextScaler.linear(textScale)),
                  child: OnboardingNavBar(
                    isFirst: false,
                    isLast: isLast,
                    onBack: () {},
                    onNext: () {},
                    onDone: () {},
                    onTakeTour: () {},
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      locale: locale,
    ));
    await tester.pump();
  }

  AppLocalizations l10nOf(WidgetTester tester) =>
      AppLocalizations.of(tester.element(find.byType(OnboardingNavBar)));

  void expectStackedFullWidthNotTruncated(WidgetTester tester, double width) {
    expect(tester.takeException(), isNull,
        reason: 'the nav bar must not overflow at this width / text size');
    final l10n = l10nOf(tester);

    final tour = find.widgetWithText(FilledButton, l10n.tourTakeQuick);
    final skip = find.widgetWithText(FilledButton, l10n.tourSkipToBoard);
    expect(tour, findsOneWidget, reason: 'the full tour label renders');
    expect(skip, findsOneWidget, reason: 'the full skip label renders');

    // Neither label may be ellipsized: these CTAs wrap, they never clip to
    // "Ta..." / "Sk...". The primary action especially must never truncate.
    expect(tester.widget<Text>(find.text(l10n.tourTakeQuick)).overflow,
        isNot(TextOverflow.ellipsis));
    expect(tester.widget<Text>(find.text(l10n.tourSkipToBoard)).overflow,
        isNot(TextOverflow.ellipsis));

    final tourRect = tester.getRect(tour);
    final skipRect = tester.getRect(skip);

    // Stacked vertically, primary ("Take the quick tour") above the tonal skip,
    // NOT side-by-side.
    expect(tourRect.center.dy, lessThan(skipRect.center.dy),
        reason: '"Take the quick tour" sits above "Skip, go to the board"');

    // Each button spans (about) the full content width, not ~1/3 of it. The old
    // Row split [Back] + [Spacer] + two [Flexible]s three ways (~88px each at
    // this width); stacked full-width is ~264px. 28+28 is the nav bar's
    // horizontal padding.
    final content = width - 28 - 28;
    expect(tourRect.width, greaterThan(content - 4),
        reason: 'the primary CTA is full-width, not a third of the row');
    expect(skipRect.width, greaterThan(content - 4),
        reason: 'the skip CTA is full-width, not a third of the row');
  }

  testWidgets(
      'en: final CTAs stack full-width and never truncate '
      '(narrow phone + large text)', (tester) async {
    await pumpNavBar(tester, width: 320, textScale: 2.0);
    expectStackedFullWidthNotTruncated(tester, 320);
  });

  testWidgets('es: final CTAs stack full-width and never truncate',
      (tester) async {
    await pumpNavBar(tester,
        width: 320, textScale: 2.0, locale: const Locale('es'));
    expectStackedFullWidthNotTruncated(tester, 320);
  });

  testWidgets('ar (RTL): final CTAs stack full-width and never truncate',
      (tester) async {
    await pumpNavBar(tester,
        width: 320, textScale: 2.0, locale: const Locale('ar'));
    expectStackedFullWidthNotTruncated(tester, 320);
  });

  testWidgets('en: final CTAs render in full at default text size on a 320px phone',
      (tester) async {
    await pumpNavBar(tester, width: 320, textScale: 1.0);
    expectStackedFullWidthNotTruncated(tester, 320);
  });

  testWidgets('pre-last screen keeps Skip + Next side-by-side (unchanged)',
      (tester) async {
    // The two pre-last labels are short ("Skip" / "Next"); a realistic phone
    // width is the right surface to confirm they stay on one row. (The wide
    // test font overflows this Row at a stress-narrow 320px, which is a
    // font-metrics artifact, not the production layout we are guarding.)
    await pumpNavBar(tester, width: 411, textScale: 1.0, isLast: false);
    expect(tester.takeException(), isNull);
    final l10n = l10nOf(tester);
    final skip = find.widgetWithText(TextButton, l10n.skip);
    final next = find.widgetWithText(FilledButton, l10n.next);
    expect(skip, findsOneWidget);
    expect(next, findsOneWidget);
    // Side-by-side on one row: same vertical center, Skip starts before Next.
    final skipRect = tester.getRect(skip);
    final nextRect = tester.getRect(next);
    expect((skipRect.center.dy - nextRect.center.dy).abs(), lessThan(4),
        reason: 'Skip and Next share a row before the last screen');
    expect(skipRect.center.dx, lessThan(nextRect.center.dx));
  });
}
