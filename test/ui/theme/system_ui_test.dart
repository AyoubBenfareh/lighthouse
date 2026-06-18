/// Edge-to-edge system-bar contract (Android 15 / API 35+).
///
/// The app is a single light theme: the cream ground shows behind the status
/// and navigation bars, so the bars must be transparent and their icons dark to
/// stay legible. This pins that contract so a future theme edit cannot silently
/// flip the icons to light (invisible on cream) or paint an opaque bar, and so
/// the AppBar keeps the same style (otherwise an app-bar rebuild drops the
/// navigation-bar fields). See LhSystemUi.overlayStyle / main().
library;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lighthouse/ui/theme/lighthouse_theme.dart';

void main() {
  group('LhSystemUi.overlayStyle (edge-to-edge)', () {
    const style = LhSystemUi.overlayStyle;

    test('both system bars are transparent (content draws behind them)', () {
      expect(style.statusBarColor, Colors.transparent);
      expect(style.systemNavigationBarColor, Colors.transparent);
      expect(style.systemNavigationBarDividerColor, Colors.transparent);
    });

    test('icons are dark so they read on the cream ground', () {
      // Android: dark glyphs.
      expect(style.statusBarIconBrightness, Brightness.dark);
      expect(style.systemNavigationBarIconBrightness, Brightness.dark);
      // iOS: a light background asks for dark status-bar text.
      expect(style.statusBarBrightness, Brightness.light);
    });

    test('no contrast scrim (flat brand look; content is inset by SafeArea)',
        () {
      expect(style.systemNavigationBarContrastEnforced, isFalse);
    });
  });

  test('AppBar theme carries the same overlay style', () {
    // A Material AppBar re-applies its overlay style on every build; if the
    // theme did not pin ours, the status-bar icons would revert to the AppBar
    // default and the navigation-bar fields would be dropped on app-bar screens.
    final theme = buildLighthouseTheme(fontFamily: 'Atkinson Hyperlegible');
    expect(theme.appBarTheme.systemOverlayStyle, LhSystemUi.overlayStyle);
  });
}
