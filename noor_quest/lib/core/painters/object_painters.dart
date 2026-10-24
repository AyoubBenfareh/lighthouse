import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Vector-style educational object illustrations (no broken asset deps).
class ObjectScenePainter extends CustomPainter {
  ObjectScenePainter(this.objectId);

  final String objectId;

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final s = math.min(size.width, size.height);

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Offset.zero & size,
        Radius.circular(s * 0.12),
      ),
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.skyBlue.withValues(alpha: 0.35),
            AppColors.cream,
          ],
        ).createShader(Offset.zero & size),
    );

    switch (objectId) {
      case 'lion':
        _lion(canvas, cx, cy, s);
      case 'door':
        _door(canvas, cx, cy, s);
      case 'apple':
        _apple(canvas, cx, cy, s);
      case 'fox':
        _fox(canvas, cx, cy, s);
      case 'camel':
        _camel(canvas, cx, cy, s);
      case 'whale':
        _whale(canvas, cx, cy, s);
      default:
        _star(canvas, cx, cy, s);
    }
  }

  void _lion(Canvas c, double cx, double cy, double s) {
    c.drawCircle(Offset(cx, cy), s * 0.28, Paint()..color = const Color(0xFFE8A84A));
    c.drawCircle(Offset(cx, cy), s * 0.2, Paint()..color = const Color(0xFFFFD27A));
    c.drawCircle(Offset(cx - s * 0.07, cy - s * 0.02), s * 0.03, Paint()..color = AppColors.darkText);
    c.drawCircle(Offset(cx + s * 0.07, cy - s * 0.02), s * 0.03, Paint()..color = AppColors.darkText);
    c.drawOval(Rect.fromCenter(center: Offset(cx, cy + s * 0.06), width: s * 0.08, height: s * 0.05), Paint()..color = AppColors.coral);
  }

  void _door(Canvas c, double cx, double cy, double s) {
    final r = RRect.fromRectAndRadius(
      Rect.fromCenter(center: Offset(cx, cy), width: s * 0.36, height: s * 0.55),
      Radius.circular(s * 0.04),
    );
    c.drawRRect(r, Paint()..color = AppColors.royalPurple);
    c.drawCircle(Offset(cx + s * 0.1, cy), s * 0.035, Paint()..color = AppColors.warmGold);
  }

  void _apple(Canvas c, double cx, double cy, double s) {
    c.drawCircle(Offset(cx, cy + s * 0.04), s * 0.22, Paint()..color = AppColors.coral);
    c.drawRect(Rect.fromCenter(center: Offset(cx, cy - s * 0.16), width: s * 0.04, height: s * 0.12), Paint()..color = const Color(0xFF6B4F2A));
    c.drawOval(Rect.fromCenter(center: Offset(cx + s * 0.08, cy - s * 0.14), width: s * 0.12, height: s * 0.06), Paint()..color = AppColors.leafGreen);
  }

  void _fox(Canvas c, double cx, double cy, double s) {
    final path = Path()
      ..moveTo(cx, cy + s * 0.18)
      ..lineTo(cx - s * 0.22, cy - s * 0.05)
      ..lineTo(cx - s * 0.1, cy - s * 0.22)
      ..lineTo(cx, cy - s * 0.08)
      ..lineTo(cx + s * 0.1, cy - s * 0.22)
      ..lineTo(cx + s * 0.22, cy - s * 0.05)
      ..close();
    c.drawPath(path, Paint()..color = const Color(0xFFE87A3A));
    c.drawCircle(Offset(cx - s * 0.06, cy - s * 0.02), s * 0.025, Paint()..color = AppColors.darkText);
    c.drawCircle(Offset(cx + s * 0.06, cy - s * 0.02), s * 0.025, Paint()..color = AppColors.darkText);
  }

  void _camel(Canvas c, double cx, double cy, double s) {
    c.drawOval(Rect.fromCenter(center: Offset(cx, cy), width: s * 0.5, height: s * 0.28), Paint()..color = const Color(0xFFD2A679));
    c.drawOval(Rect.fromCenter(center: Offset(cx - s * 0.08, cy - s * 0.12), width: s * 0.18, height: s * 0.16), Paint()..color = const Color(0xFFD2A679));
    c.drawCircle(Offset(cx + s * 0.2, cy - s * 0.02), s * 0.08, Paint()..color = const Color(0xFFD2A679));
  }

  void _whale(Canvas c, double cx, double cy, double s) {
    c.drawOval(Rect.fromCenter(center: Offset(cx, cy), width: s * 0.55, height: s * 0.28), Paint()..color = AppColors.skyBlue);
    final fin = Path()
      ..moveTo(cx - s * 0.22, cy)
      ..lineTo(cx - s * 0.35, cy - s * 0.12)
      ..lineTo(cx - s * 0.35, cy + s * 0.12)
      ..close();
    c.drawPath(fin, Paint()..color = AppColors.primaryViolet);
    c.drawCircle(Offset(cx + s * 0.14, cy - s * 0.02), s * 0.025, Paint()..color = AppColors.darkText);
  }

  void _star(Canvas c, double cx, double cy, double s) {
    c.drawCircle(Offset(cx, cy), s * 0.2, Paint()..color = AppColors.warmGold);
  }

  @override
  bool shouldRepaint(covariant ObjectScenePainter oldDelegate) =>
      oldDelegate.objectId != objectId;
}

class ObjectScene extends StatelessWidget {
  const ObjectScene({super.key, required this.objectId, this.size = 160});

  final String objectId;
  final double size;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.square(size),
      painter: ObjectScenePainter(objectId),
    );
  }
}
