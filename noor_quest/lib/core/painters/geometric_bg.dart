import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class GeometricBackground extends StatelessWidget {
  const GeometricBackground({
    super.key,
    required this.child,
    this.topColor = AppColors.primaryViolet,
    this.bottomColor = AppColors.cream,
  });

  final Widget child;
  final Color topColor;
  final Color bottomColor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                topColor.withValues(alpha: 0.35),
                bottomColor,
                AppColors.softTurquoise.withValues(alpha: 0.25),
              ],
            ),
          ),
        ),
        CustomPaint(painter: _PatternPainter()),
        child,
      ],
    );
  }
}

class _PatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.royalPurple.withValues(alpha: 0.06)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;
    const step = 48.0;
    for (var y = 0.0; y < size.height; y += step) {
      for (var x = 0.0; x < size.width; x += step) {
        final cx = x + ((y ~/ step).isEven ? 0 : step / 2);
        canvas.drawCircle(Offset(cx, y), 10, paint);
        canvas.drawCircle(Offset(cx, y), 4, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
