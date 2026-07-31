import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lighthouse/ui/ui.dart';

import '../../support/localized.dart';

void main() {
  Widget _host(VoidCallback onUnlocked) {
    return localizedApp(
      Scaffold(
        body: MathGate(
          questionSeed: (a: 5, b: 7),
          onUnlocked: onUnlocked,
        ),
      ),
    );
  }

  // The gate uses an on-screen keypad (not the platform soft keyboard, which is
  // unreliable on a tethered tablet, clinical review). Each digit key carries a
  // ValueKey('mathkey_<n>'); the submit button is ValueKey('mathgate_continue').
  Future<void> tapDigits(WidgetTester tester, String digits) async {
    for (final d in digits.split('')) {
      await tester.tap(find.byKey(ValueKey('mathkey_$d')));
      await tester.pump();
    }
  }

  testWidgets('Correct answer fires onUnlocked', (tester) async {
    var unlocked = false;
    tester.view.physicalSize = const Size(1000, 1600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(_host(() => unlocked = true));
    await tester.pump();

    await tapDigits(tester, '12');
    await tester.tap(find.byKey(const ValueKey('mathgate_continue')));
    await tester.pump();

    expect(unlocked, isTrue);
  });

  testWidgets('Wrong answer rejects with error text and stays gated',
      (tester) async {
    var unlocked = false;
    tester.view.physicalSize = const Size(1000, 1600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(_host(() => unlocked = true));
    await tester.pump();

    await tapDigits(tester, '11');
    await tester.tap(find.byKey(const ValueKey('mathgate_continue')));
    await tester.pump();

    expect(unlocked, isFalse);
    expect(find.text('Not quite. Try again.'), findsOneWidget);
  });

  testWidgets('Empty submission cannot unlock (submit is disabled)',
      (tester) async {
    var unlocked = false;
    tester.view.physicalSize = const Size(1000, 1600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(_host(() => unlocked = true));
    await tester.pump();

    // With no digits entered the submit button is disabled; tapping is a no-op.
    await tester.tap(find.byKey(const ValueKey('mathgate_continue')));
    await tester.pump();

    expect(unlocked, isFalse);
  });

  testWidgets('Backspace corrects a mistyped digit', (tester) async {
    var unlocked = false;
    tester.view.physicalSize = const Size(1000, 1600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(_host(() => unlocked = true));
    await tester.pump();

    // Type 19, backspace the 9, type 2 -> 12 (correct for 5 + 7).
    await tapDigits(tester, '19');
    await tester.tap(find.byKey(const ValueKey('mathkey_backspace')));
    await tester.pump();
    await tapDigits(tester, '2');
    await tester.tap(find.byKey(const ValueKey('mathgate_continue')));
    await tester.pump();

    expect(unlocked, isTrue);
  });

  testWidgets('Renders and unlocks under Arabic locale (RTL, localized button)',
      (tester) async {
    var unlocked = false;
    tester.view.physicalSize = const Size(1000, 1600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(localizedApp(
      Scaffold(
        body: MathGate(
          questionSeed: (a: 5, b: 7),
          onUnlocked: () => unlocked = true,
        ),
      ),
      locale: const Locale('ar'),
    ));
    await tester.pump();

    // The gate builds under ar/RTL and the keypad renders.
    expect(find.byType(MathGate), findsOneWidget);
    expect(find.byKey(const ValueKey('mathkey_1')), findsOneWidget);

    await tapDigits(tester, '12');
    await tester.tap(find.byKey(const ValueKey('mathgate_continue')));
    await tester.pump();

    expect(unlocked, isTrue,
        reason: 'the parental math gate must work identically under ar/RTL');
  });

  // Regression: on a narrow PHONE-width dialog the equation + answer-box row
  // overflowed and clipped (the answer box in LTR, the first operand in RTL).
  // It must now scale to fit with no overflow. The tests above use a 1000pt
  // surface, which is why this went unseen; a real Dialog on a phone is ~250pt
  // wide. Guards the FittedBox around the equation row in math_gate.dart.
  for (final locale in const [Locale('en'), Locale('ar')]) {
    testWidgets(
        'equation row fits a narrow phone dialog without overflow (${locale.languageCode})',
        (tester) async {
      tester.view.physicalSize = const Size(330, 720);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(localizedApp(
        // Widest single-digit sum, 9 + 8 = ? (17), to stress the row width.
        Dialog(
          child: MathGate(
            questionSeed: (a: 9, b: 8),
            onUnlocked: () {},
          ),
        ),
        locale: locale,
      ));
      await tester.pump();

      expect(tester.takeException(), isNull,
          reason: 'the equation + answer box must scale to fit a phone-width '
              'dialog, not overflow and clip');
      expect(find.byType(MathGate), findsOneWidget);
      // Equation rendered (contains the "+"; the "= ?" glyph is locale-specific,
      // Arabic uses U+061F), and the keypad rendered.
      expect(find.textContaining('9 + 8'), findsOneWidget);
      expect(find.byKey(const ValueKey('mathkey_9')), findsOneWidget);
    });
  }
}
