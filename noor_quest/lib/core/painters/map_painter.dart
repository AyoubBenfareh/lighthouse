import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class AdventureMapPainter extends CustomPainter {
  AdventureMapPainter({this.t = 0});

  final double t;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;

    // Sky / sea gradient backdrop
    canvas.drawRect(
      rect,
      Paint()
        ..shader = const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFB8E4F5),
            Color(0xFF7EC8E8),
            Color(0xFF6DD9C5),
            Color(0xFFFFF0C8),
          ],
          stops: [0, 0.35, 0.7, 1],
        ).createShader(rect),
    );

    // Soft geometric pattern strip
    final patternPaint = Paint()
      ..color = AppColors.royalPurple.withValues(alpha: 0.08)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    for (var i = 0; i < 8; i++) {
      final y = size.height * (0.1 + i * 0.1);
      for (var x = 0.0; x < size.width; x += 36) {
        canvas.drawCircle(Offset(x + (i.isEven ? 0 : 18), y), 8, patternPaint);
      }
    }

    // Islands
    _island(canvas, Offset(size.width * 0.18, size.height * 0.32), size.width * 0.16, const Color(0xFF7EC8E8));
    _island(canvas, Offset(size.width * 0.55, size.height * 0.22), size.width * 0.15, AppColors.softTurquoise);
    _island(canvas, Offset(size.width * 0.78, size.height * 0.42), size.width * 0.14, AppColors.leafGreen);
    _island(canvas, Offset(size.width * 0.32, size.height * 0.68), size.width * 0.16, AppColors.softPink);
    _island(canvas, Offset(size.width * 0.72, size.height * 0.72), size.width * 0.15, AppColors.warmGold);

    // Path dots
    final pathPaint = Paint()..color = Colors.white.withValues(alpha: 0.85);
    final points = [
      Offset(size.width * 0.22, size.height * 0.38),
      Offset(size.width * 0.35, size.height * 0.3),
      Offset(size.width * 0.48, size.height * 0.26),
      Offset(size.width * 0.4, size.height * 0.5),
      Offset(size.width * 0.35, size.height * 0.6),
      Offset(size.width * 0.55, size.height * 0.55),
      Offset(size.width * 0.65, size.height * 0.65),
    ];
    for (final p in points) {
      canvas.drawCircle(p, 5 + math.sin(t * math.pi * 2 + p.dx) * 1.5, pathPaint);
    }

    // Decorative crescent & stars
    _crescent(canvas, Offset(size.width * 0.88, size.height * 0.12), 22);
    for (final star in [
      Offset(size.width * 0.1, size.height * 0.12),
      Offset(size.width * 0.42, size.height * 0.08),
      Offset(size.width * 0.92, size.height * 0.28),
    ]) {
      _star(canvas, star, 7 + math.sin(t * 4 + star.dx) * 1.5);
    }
  }

  void _island(Canvas canvas, Offset c, double r, Color color) {
    canvas.drawOval(
      Rect.fromCenter(center: c.translate(0, r * 0.15), width: r * 2.1, height: r * 0.7),
      Paint()..color = const Color(0xFF4A90A8).withValues(alpha: 0.25),
    );
    canvas.drawOval(
      Rect.fromCenter(center: c, width: r * 2, height: r * 1.2),
      Paint()..color = color,
    );
    canvas.drawOval(
      Rect.fromCenter(center: c.translate(0, -r * 0.15), width: r * 1.4, height: r * 0.7),
      Paint()..color = Colors.white.withValues(alpha: 0.25),
    );
  }

  void _crescent(Canvas canvas, Offset c, double r) {
    canvas.drawCircle(c, r, Paint()..color = AppColors.warmGold);
    canvas.drawCircle(c.translate(r * 0.35, 0), r * 0.78, Paint()..color = const Color(0xFFB8E4F5));
  }

  void _star(Canvas canvas, Offset c, double r) {
    canvas.drawCircle(c, r, Paint()..color = Colors.white.withValues(alpha: 0.9));
  }

  @override
  bool shouldRepaint(covariant AdventureMapPainter oldDelegate) =>
      oldDelegate.t != t;
}
