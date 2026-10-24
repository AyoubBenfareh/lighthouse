import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Kawaii glowing lantern companion — richer V2 identity.
class NoorLanternPainter extends CustomPainter {
  NoorLanternPainter({this.glow = 1.0, this.blink = 0.0, this.sparkle = 0.0});

  final double glow;
  final double blink;
  final double sparkle;

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final scale = math.min(size.width, size.height);

    // Aura
    canvas.drawCircle(
      Offset(cx, cy),
      scale * 0.55,
      Paint()
        ..shader = RadialGradient(
          colors: [
            AppColors.warmGold.withValues(alpha: 0.5 * glow),
            AppColors.warmGold.withValues(alpha: 0.0),
          ],
        ).createShader(Rect.fromCircle(center: Offset(cx, cy), radius: scale * 0.55)),
    );

    // Decorative floating stars
    for (var i = 0; i < 5; i++) {
      final a = sparkle * math.pi * 2 + i * 1.2;
      final r = scale * (0.38 + 0.06 * math.sin(sparkle * 4 + i));
      final p = Offset(cx + math.cos(a) * r, cy + math.sin(a) * r * 0.7);
      _miniStar(canvas, p, scale * 0.035, [
        AppColors.skyBlue,
        AppColors.warmGold,
        AppColors.softTurquoise,
        AppColors.softPink,
        const Color(0xFFFFB347),
      ][i]);
    }

    // Body (gold metal frame)
    final bodyRect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: Offset(cx, cy + scale * 0.04), width: scale * 0.46, height: scale * 0.58),
      Radius.circular(scale * 0.12),
    );
    canvas.drawRRect(
      bodyRect,
      Paint()
        ..shader = const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFFE08A), AppColors.warmGold, Color(0xFFD4923A)],
        ).createShader(bodyRect.outerRect),
    );
    canvas.drawRRect(
      bodyRect,
      Paint()
        ..color = AppColors.royalPurple.withValues(alpha: 0.55)
        ..style = PaintingStyle.stroke
        ..strokeWidth = scale * 0.02,
    );

    // Glass window + inner sparkle
    final window = RRect.fromRectAndRadius(
      Rect.fromCenter(center: Offset(cx, cy + scale * 0.02), width: scale * 0.3, height: scale * 0.36),
      Radius.circular(scale * 0.08),
    );
    canvas.drawRRect(
      window,
      Paint()
        ..shader = LinearGradient(
          colors: [
            Colors.white.withValues(alpha: 0.95),
            const Color(0xFFFFF4C2),
            AppColors.warmGold.withValues(alpha: 0.55),
          ],
        ).createShader(window.outerRect),
    );

    // Flame
    final flame = Path()
      ..moveTo(cx, cy - scale * 0.1)
      ..quadraticBezierTo(cx + scale * 0.07, cy + scale * 0.02, cx, cy + scale * 0.12)
      ..quadraticBezierTo(cx - scale * 0.07, cy + scale * 0.02, cx, cy - scale * 0.1);
    canvas.drawPath(
      flame,
      Paint()
        ..shader = const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFFFF4C2), Color(0xFFFF9A3C)],
        ).createShader(Rect.fromCircle(center: Offset(cx, cy), radius: scale * 0.14)),
    );

    // Eyes (kawaii)
    final eyeY = cy + scale * 0.02;
    final open = (1.0 - blink).clamp(0.12, 1.0);
    _eye(canvas, Offset(cx - scale * 0.08, eyeY), scale * 0.055, open);
    _eye(canvas, Offset(cx + scale * 0.08, eyeY), scale * 0.055, open);

    // Rosy cheeks
    for (final dx in [-0.16, 0.16]) {
      canvas.drawCircle(
        Offset(cx + scale * dx, cy + scale * 0.12),
        scale * 0.04,
        Paint()..color = AppColors.softPink.withValues(alpha: 0.75),
      );
    }

    // Open smile
    final mouth = Path()
      ..moveTo(cx - scale * 0.05, cy + scale * 0.14)
      ..quadraticBezierTo(cx, cy + scale * 0.2, cx + scale * 0.05, cy + scale * 0.14)
      ..quadraticBezierTo(cx, cy + scale * 0.17, cx - scale * 0.05, cy + scale * 0.14);
    canvas.drawPath(mouth, Paint()..color = AppColors.royalPurple);

    // Cap with crescent + stars engraving
    final cap = Path()
      ..moveTo(cx - scale * 0.2, cy - scale * 0.22)
      ..lineTo(cx + scale * 0.2, cy - scale * 0.22)
      ..lineTo(cx + scale * 0.14, cy - scale * 0.34)
      ..lineTo(cx - scale * 0.14, cy - scale * 0.34)
      ..close();
    canvas.drawPath(cap, Paint()..color = AppColors.royalPurple);
    canvas.drawCircle(Offset(cx, cy - scale * 0.38), scale * 0.045, Paint()..color = AppColors.softTurquoise);

    canvas.drawCircle(Offset(cx + scale * 0.05, cy - scale * 0.28), scale * 0.04, Paint()..color = AppColors.warmGold);
    canvas.drawCircle(Offset(cx + scale * 0.065, cy - scale * 0.28), scale * 0.03, Paint()..color = AppColors.royalPurple);
    _miniStar(canvas, Offset(cx - scale * 0.06, cy - scale * 0.28), scale * 0.025, AppColors.warmGold);
  }

  void _eye(Canvas canvas, Offset c, double r, double open) {
    canvas.drawOval(
      Rect.fromCenter(center: c, width: r * 2, height: r * 2 * open),
      Paint()..color = AppColors.darkText,
    );
    if (open > 0.4) {
      canvas.drawCircle(c.translate(-r * 0.3, -r * 0.3), r * 0.35, Paint()..color = Colors.white);
      canvas.drawCircle(c.translate(r * 0.25, r * 0.2), r * 0.12, Paint()..color = Colors.white70);
    }
  }

  void _miniStar(Canvas canvas, Offset c, double r, Color color) {
    final path = Path();
    for (var i = 0; i < 10; i++) {
      final ang = -math.pi / 2 + i * math.pi / 5;
      final rr = i.isEven ? r : r * 0.4;
      final p = Offset(c.dx + rr * math.cos(ang), c.dy + rr * math.sin(ang));
      if (i == 0) {
        path.moveTo(p.dx, p.dy);
      } else {
        path.lineTo(p.dx, p.dy);
      }
    }
    path.close();
    canvas.drawPath(path, Paint()..color = color);
  }

  @override
  bool shouldRepaint(covariant NoorLanternPainter oldDelegate) =>
      oldDelegate.glow != glow ||
      oldDelegate.blink != blink ||
      oldDelegate.sparkle != sparkle;
}

class AnimatedNoorLantern extends StatefulWidget {
  const AnimatedNoorLantern({
    super.key,
    this.size = 160,
    this.reducedMotion = false,
  });

  final double size;
  final bool reducedMotion;

  @override
  State<AnimatedNoorLantern> createState() => _AnimatedNoorLanternState();
}

class _AnimatedNoorLanternState extends State<AnimatedNoorLantern>
    with TickerProviderStateMixin {
  late final AnimationController _glow;
  late final AnimationController _blink;
  late final AnimationController _sparkle;

  @override
  void initState() {
    super.initState();
    _glow = AnimationController(vsync: this, duration: const Duration(milliseconds: 1800));
    _blink = AnimationController(vsync: this, duration: const Duration(milliseconds: 160));
    _sparkle = AnimationController(vsync: this, duration: const Duration(seconds: 6));
    if (!widget.reducedMotion) {
      _glow.repeat(reverse: true);
      _sparkle.repeat();
      _scheduleBlink();
    }
  }

  void _scheduleBlink() async {
    while (mounted && !widget.reducedMotion) {
      await Future<void>.delayed(
        Duration(milliseconds: 2000 + DateTime.now().millisecond % 1400),
      );
      if (!mounted || widget.reducedMotion) return;
      await _blink.forward();
      await _blink.reverse();
    }
  }

  @override
  void didUpdateWidget(covariant AnimatedNoorLantern oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.reducedMotion && !oldWidget.reducedMotion) {
      _glow.stop();
      _blink.stop();
      _sparkle.stop();
    } else if (!widget.reducedMotion && oldWidget.reducedMotion) {
      _glow.repeat(reverse: true);
      _sparkle.repeat();
      _scheduleBlink();
    }
  }

  @override
  void dispose() {
    _glow.dispose();
    _blink.dispose();
    _sparkle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_glow, _blink, _sparkle]),
      builder: (context, _) {
        return CustomPaint(
          size: Size.square(widget.size),
          painter: NoorLanternPainter(
            glow: widget.reducedMotion ? 0.9 : 0.7 + _glow.value * 0.4,
            blink: _blink.value,
            sparkle: widget.reducedMotion ? 0 : _sparkle.value,
          ),
        );
      },
    );
  }
}
