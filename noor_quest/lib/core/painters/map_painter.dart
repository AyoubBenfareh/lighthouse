import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../../data/models/world_info.dart';

/// Illustrated adventure map backdrop with distinct islands and paths.
class AdventureMapPainter extends CustomPainter {
  AdventureMapPainter({this.t = 0});

  final double t;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;

    canvas.drawRect(
      rect,
      Paint()
        ..shader = const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF7EC8E8),
            Color(0xFFB8E4F5),
            Color(0xFF9FE0C8),
            Color(0xFFE8F6C8),
          ],
          stops: [0, 0.35, 0.7, 1],
        ).createShader(rect),
    );

    // Clouds drifting
    final cloudPaint = Paint()..color = Colors.white.withValues(alpha: 0.7);
    for (var i = 0; i < 4; i++) {
      final x = (size.width * (0.1 + i * 0.22) + t * 40 * (i.isEven ? 1 : -1)) %
          (size.width + 80) -
          40;
      final y = size.height * (0.08 + i * 0.04);
      canvas.drawOval(Rect.fromCenter(center: Offset(x, y), width: 70, height: 28), cloudPaint);
      canvas.drawOval(
        Rect.fromCenter(center: Offset(x + 24, y - 4), width: 48, height: 22),
        cloudPaint,
      );
    }

    // Ground meadow
    final meadow = Path()
      ..moveTo(0, size.height)
      ..lineTo(0, size.height * 0.82)
      ..quadraticBezierTo(size.width * 0.3, size.height * 0.74, size.width * 0.55, size.height * 0.8)
      ..quadraticBezierTo(size.width * 0.8, size.height * 0.86, size.width, size.height * 0.78)
      ..lineTo(size.width, size.height)
      ..close();
    canvas.drawPath(meadow, Paint()..color = const Color(0xFF7BC47F).withValues(alpha: 0.55));

    // Path ribbon connecting islands
    final path = Path()
      ..moveTo(size.width * 0.18, size.height * 0.38)
      ..quadraticBezierTo(size.width * 0.35, size.height * 0.28, size.width * 0.55, size.height * 0.26)
      ..quadraticBezierTo(size.width * 0.7, size.height * 0.35, size.width * 0.78, size.height * 0.45)
      ..quadraticBezierTo(size.width * 0.55, size.height * 0.55, size.width * 0.32, size.height * 0.68)
      ..quadraticBezierTo(size.width * 0.55, size.height * 0.72, size.width * 0.72, size.height * 0.74);
    canvas.drawPath(
      path,
      Paint()
        ..color = Colors.white.withValues(alpha: 0.75)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 10
        ..strokeCap = StrokeCap.round,
    );
    canvas.drawPath(
      path,
      Paint()
        ..color = AppColors.warmGold.withValues(alpha: 0.85)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4
        ..strokeCap = StrokeCap.round,
    );

    // Dashed stepping stones along path
    for (var i = 0; i < 12; i++) {
      final tt = i / 11;
      final p = _quadSample(size, tt);
      final pulse = 4.5 + math.sin(t * math.pi * 2 + i) * 1.2;
      canvas.drawCircle(p, pulse, Paint()..color = Colors.white);
      canvas.drawCircle(p, pulse * 0.45, Paint()..color = AppColors.warmGold);
    }

    // Distinct islands
    _island(
      canvas,
      Offset(size.width * 0.18, size.height * 0.32),
      size.width * 0.13,
      const Color(0xFF7EC8E8),
      accent: AppColors.royalPurple,
      motif: IslandMotif.book,
    );
    _island(
      canvas,
      Offset(size.width * 0.55, size.height * 0.22),
      size.width * 0.12,
      AppColors.softTurquoise,
      accent: AppColors.primaryViolet,
      motif: IslandMotif.dome,
    );
    _island(
      canvas,
      Offset(size.width * 0.78, size.height * 0.42),
      size.width * 0.12,
      AppColors.leafGreen,
      accent: const Color(0xFFF5A9C5),
      motif: IslandMotif.garden,
    );
    _island(
      canvas,
      Offset(size.width * 0.32, size.height * 0.68),
      size.width * 0.13,
      AppColors.softPink,
      accent: AppColors.warmGold,
      motif: IslandMotif.village,
    );
    _island(
      canvas,
      Offset(size.width * 0.72, size.height * 0.72),
      size.width * 0.12,
      AppColors.warmGold,
      accent: AppColors.skyBlue,
      motif: IslandMotif.oasis,
    );

    // Ambient birds
    final birdY = size.height * 0.16 + math.sin(t * math.pi * 2) * 6;
    _bird(canvas, Offset(size.width * 0.4 + t * 30 % 40, birdY), 8);
    _bird(canvas, Offset(size.width * 0.48 + t * 20 % 30, birdY + 12), 6);
  }

  Offset _quadSample(Size size, double t) {
    // Approximate polyline through island centers
    final pts = [
      Offset(size.width * 0.18, size.height * 0.36),
      Offset(size.width * 0.35, size.height * 0.28),
      Offset(size.width * 0.55, size.height * 0.26),
      Offset(size.width * 0.7, size.height * 0.38),
      Offset(size.width * 0.5, size.height * 0.55),
      Offset(size.width * 0.32, size.height * 0.66),
      Offset(size.width * 0.55, size.height * 0.7),
      Offset(size.width * 0.72, size.height * 0.74),
    ];
    final f = t * (pts.length - 1);
    final i = f.floor().clamp(0, pts.length - 2);
    final lt = f - i;
    return Offset.lerp(pts[i], pts[i + 1], lt)!;
  }

  void _island(
    Canvas canvas,
    Offset c,
    double r,
    Color color, {
    required Color accent,
    required IslandMotif motif,
  }) {
    // Shadow
    canvas.drawOval(
      Rect.fromCenter(center: c.translate(0, r * 0.35), width: r * 2.2, height: r * 0.55),
      Paint()..color = const Color(0xFF3A6B7A).withValues(alpha: 0.22),
    );
    // Landmass
    canvas.drawOval(
      Rect.fromCenter(center: c, width: r * 2.1, height: r * 1.25),
      Paint()..color = color,
    );
    canvas.drawOval(
      Rect.fromCenter(center: c.translate(0, -r * 0.12), width: r * 1.5, height: r * 0.7),
      Paint()..color = Colors.white.withValues(alpha: 0.28),
    );

    switch (motif) {
      case IslandMotif.book:
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromCenter(center: c.translate(0, -r * 0.05), width: r * 0.9, height: r * 0.7),
            Radius.circular(r * 0.08),
          ),
          Paint()..color = accent,
        );
        canvas.drawLine(
          c.translate(-r * 0.35, -r * 0.05),
          c.translate(r * 0.35, -r * 0.05),
          Paint()
            ..color = Colors.white
            ..strokeWidth = 2,
        );
      case IslandMotif.dome:
        canvas.drawRect(
          Rect.fromCenter(center: c.translate(0, r * 0.05), width: r * 0.7, height: r * 0.45),
          Paint()..color = Colors.white.withValues(alpha: 0.9),
        );
        canvas.drawArc(
          Rect.fromCenter(center: c.translate(0, -r * 0.1), width: r * 0.7, height: r * 0.55),
          math.pi,
          math.pi,
          true,
          Paint()..color = accent,
        );
      case IslandMotif.garden:
        for (final dx in [-0.25, 0.0, 0.25]) {
          canvas.drawCircle(
            c.translate(r * dx, -r * 0.05),
            r * 0.12,
            Paint()..color = accent,
          );
          canvas.drawRect(
            Rect.fromCenter(center: c.translate(r * dx, r * 0.12), width: r * 0.05, height: r * 0.2),
            Paint()..color = const Color(0xFF5A8F4A),
          );
        }
      case IslandMotif.village:
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromCenter(center: c, width: r * 0.7, height: r * 0.5),
            Radius.circular(r * 0.08),
          ),
          Paint()..color = Colors.white.withValues(alpha: 0.92),
        );
        canvas.drawCircle(c.translate(0, -r * 0.05), r * 0.12, Paint()..color = accent);
      case IslandMotif.oasis:
        canvas.drawOval(
          Rect.fromCenter(center: c, width: r * 0.85, height: r * 0.45),
          Paint()..color = AppColors.skyBlue,
        );
        canvas.drawCircle(c.translate(r * 0.2, -r * 0.15), r * 0.1, Paint()..color = accent);
    }
  }

  void _bird(Canvas canvas, Offset c, double s) {
    final p = Path()
      ..moveTo(c.dx - s, c.dy)
      ..quadraticBezierTo(c.dx - s * 0.3, c.dy - s * 0.6, c.dx, c.dy)
      ..quadraticBezierTo(c.dx + s * 0.3, c.dy - s * 0.6, c.dx + s, c.dy);
    canvas.drawPath(
      p,
      Paint()
        ..color = AppColors.darkText.withValues(alpha: 0.45)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.8
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(covariant AdventureMapPainter oldDelegate) => oldDelegate.t != t;
}

enum IslandMotif { book, dome, garden, village, oasis }

/// World pin accent colors helper
Color worldAccent(WorldId id) {
  return switch (id) {
    WorldId.arabic => const Color(0xFF7EC8E8),
    WorldId.prayer => AppColors.softTurquoise,
    WorldId.garden => AppColors.leafGreen,
    WorldId.manners => AppColors.softPink,
    WorldId.quran => AppColors.warmGold,
  };
}
