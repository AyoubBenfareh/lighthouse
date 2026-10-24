import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Soft sky / landscape atmosphere — no repetitive circle lattice.
class GeometricBackground extends StatelessWidget {
  const GeometricBackground({
    super.key,
    required this.child,
    this.topColor = AppColors.primaryViolet,
    this.bottomColor = AppColors.cream,
    this.variant = BgVariant.sky,
  });

  final Widget child;
  final Color topColor;
  final Color bottomColor;
  final BgVariant variant;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.lerp(topColor, const Color(0xFFB8E4F5), 0.45)!,
                bottomColor,
                Color.lerp(bottomColor, AppColors.softTurquoise, 0.2)!,
              ],
            ),
          ),
        ),
        CustomPaint(painter: _AtmospherePainter(variant: variant)),
        child,
      ],
    );
  }
}

enum BgVariant { sky, garden, prayer, desert, oasis }

class _AtmospherePainter extends CustomPainter {
  _AtmospherePainter({required this.variant});

  final BgVariant variant;

  @override
  void paint(Canvas canvas, Size size) {
    // Soft clouds
    final cloud = Paint()..color = Colors.white.withValues(alpha: 0.55);
    for (final o in [
      Offset(size.width * 0.15, size.height * 0.12),
      Offset(size.width * 0.7, size.height * 0.08),
      Offset(size.width * 0.45, size.height * 0.18),
    ]) {
      canvas.drawOval(Rect.fromCenter(center: o, width: 90, height: 36), cloud);
      canvas.drawOval(Rect.fromCenter(center: o.translate(28, -6), width: 60, height: 28), cloud);
    }

    // Distant hills / dunes by variant
    final hill = Path()
      ..moveTo(0, size.height)
      ..lineTo(0, size.height * 0.78)
      ..quadraticBezierTo(size.width * 0.25, size.height * 0.68, size.width * 0.5, size.height * 0.76)
      ..quadraticBezierTo(size.width * 0.75, size.height * 0.84, size.width, size.height * 0.72)
      ..lineTo(size.width, size.height)
      ..close();

    final hillColor = switch (variant) {
      BgVariant.garden => AppColors.leafGreen.withValues(alpha: 0.35),
      BgVariant.prayer => AppColors.softTurquoise.withValues(alpha: 0.35),
      BgVariant.desert => const Color(0xFFE8C48A).withValues(alpha: 0.45),
      BgVariant.oasis => AppColors.skyBlue.withValues(alpha: 0.3),
      BgVariant.sky => AppColors.primaryViolet.withValues(alpha: 0.12),
    };
    canvas.drawPath(hill, Paint()..color = hillColor);

    // Sparse crescent / star accents (not a grid)
    _crescent(canvas, Offset(size.width * 0.88, size.height * 0.14), 16);
    for (final p in [
      Offset(size.width * 0.1, size.height * 0.22),
      Offset(size.width * 0.92, size.height * 0.28),
    ]) {
      _star(canvas, p, 5);
    }
  }

  void _crescent(Canvas canvas, Offset c, double r) {
    canvas.drawCircle(c, r, Paint()..color = AppColors.warmGold.withValues(alpha: 0.85));
    canvas.drawCircle(
      c.translate(r * 0.35, 0),
      r * 0.78,
      Paint()..color = const Color(0xFFB8E4F5),
    );
  }

  void _star(Canvas canvas, Offset c, double r) {
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
    canvas.drawPath(path, Paint()..color = Colors.white.withValues(alpha: 0.85));
  }

  @override
  bool shouldRepaint(covariant _AtmospherePainter oldDelegate) =>
      oldDelegate.variant != variant;
}
