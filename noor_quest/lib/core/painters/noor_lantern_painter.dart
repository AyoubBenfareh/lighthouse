import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Friendly glowing lantern companion — CustomPainter vector art.
class NoorLanternPainter extends CustomPainter {
  NoorLanternPainter({this.glow = 1.0, this.blink = 0.0});

  final double glow;
  final double blink;

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final scale = math.min(size.width, size.height);

    // Soft aura
    final aura = Paint()
      ..shader = RadialGradient(
        colors: [
          AppColors.warmGold.withValues(alpha: 0.45 * glow),
          AppColors.warmGold.withValues(alpha: 0.0),
        ],
      ).createShader(Rect.fromCircle(center: Offset(cx, cy), radius: scale * 0.55));
    canvas.drawCircle(Offset(cx, cy), scale * 0.55, aura);

    // Body
    final bodyRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(cx, cy + scale * 0.02),
        width: scale * 0.42,
        height: scale * 0.55,
      ),
      Radius.circular(scale * 0.12),
    );
    final bodyPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFFFE08A), AppColors.warmGold, Color(0xFFE8A84A)],
      ).createShader(bodyRect.outerRect);
    canvas.drawRRect(bodyRect, bodyPaint);

    // Glass window
    final window = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(cx, cy + scale * 0.02),
        width: scale * 0.26,
        height: scale * 0.34,
      ),
      Radius.circular(scale * 0.08),
    );
    canvas.drawRRect(
      window,
      Paint()
        ..shader = LinearGradient(
          colors: [
            Colors.white.withValues(alpha: 0.85),
            AppColors.warmGold.withValues(alpha: 0.5),
          ],
        ).createShader(window.outerRect),
    );

    // Flame
    final flamePath = Path()
      ..moveTo(cx, cy - scale * 0.08)
      ..quadraticBezierTo(
        cx + scale * 0.06,
        cy + scale * 0.02,
        cx,
        cy + scale * 0.1,
      )
      ..quadraticBezierTo(
        cx - scale * 0.06,
        cy + scale * 0.02,
        cx,
        cy - scale * 0.08,
      );
    canvas.drawPath(
      flamePath,
      Paint()
        ..shader = const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFFFF4C2), Color(0xFFFF9A3C)],
        ).createShader(Rect.fromCircle(center: Offset(cx, cy), radius: scale * 0.12)),
    );

    // Eyes
    final eyeY = cy - scale * 0.02;
    final eyeOpen = 1.0 - blink;
    _drawEye(canvas, Offset(cx - scale * 0.07, eyeY), scale * 0.035, eyeOpen);
    _drawEye(canvas, Offset(cx + scale * 0.07, eyeY), scale * 0.035, eyeOpen);

    // Smile
    final smile = Path()
      ..moveTo(cx - scale * 0.06, cy + scale * 0.08)
      ..quadraticBezierTo(
        cx,
        cy + scale * 0.14,
        cx + scale * 0.06,
        cy + scale * 0.08,
      );
    canvas.drawPath(
      smile,
      Paint()
        ..color = AppColors.royalPurple
        ..style = PaintingStyle.stroke
        ..strokeWidth = scale * 0.018
        ..strokeCap = StrokeCap.round,
    );

    // Cap
    final cap = Path()
      ..moveTo(cx - scale * 0.18, cy - scale * 0.22)
      ..lineTo(cx + scale * 0.18, cy - scale * 0.22)
      ..lineTo(cx + scale * 0.12, cy - scale * 0.32)
      ..lineTo(cx - scale * 0.12, cy - scale * 0.32)
      ..close();
    canvas.drawPath(cap, Paint()..color = AppColors.royalPurple);
    canvas.drawCircle(
      Offset(cx, cy - scale * 0.36),
      scale * 0.04,
      Paint()..color = AppColors.softTurquoise,
    );

    // Crescent on cap
    canvas.drawCircle(
      Offset(cx + scale * 0.04, cy - scale * 0.27),
      scale * 0.035,
      Paint()..color = AppColors.warmGold,
    );
    canvas.drawCircle(
      Offset(cx + scale * 0.055, cy - scale * 0.27),
      scale * 0.028,
      Paint()..color = AppColors.royalPurple,
    );
  }

  void _drawEye(Canvas canvas, Offset c, double r, double open) {
    canvas.drawOval(
      Rect.fromCenter(center: c, width: r * 2, height: r * 2 * open.clamp(0.15, 1.0)),
      Paint()..color = AppColors.darkText,
    );
    if (open > 0.4) {
      canvas.drawCircle(
        c.translate(-r * 0.25, -r * 0.25),
        r * 0.35,
        Paint()..color = Colors.white,
      );
    }
  }

  @override
  bool shouldRepaint(covariant NoorLanternPainter oldDelegate) =>
      oldDelegate.glow != glow || oldDelegate.blink != blink;
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

  @override
  void initState() {
    super.initState();
    _glow = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );
    _blink = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 180),
    );
    if (!widget.reducedMotion) {
      _glow.repeat(reverse: true);
      _scheduleBlink();
    }
  }

  void _scheduleBlink() async {
    while (mounted && !widget.reducedMotion) {
      await Future<void>.delayed(Duration(milliseconds: 2200 + (DateTime.now().millisecond % 1200)));
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
    } else if (!widget.reducedMotion && oldWidget.reducedMotion) {
      _glow.repeat(reverse: true);
      _scheduleBlink();
    }
  }

  @override
  void dispose() {
    _glow.dispose();
    _blink.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_glow, _blink]),
      builder: (context, _) {
        return CustomPaint(
          size: Size.square(widget.size),
          painter: NoorLanternPainter(
            glow: widget.reducedMotion ? 0.85 : 0.7 + _glow.value * 0.4,
            blink: _blink.value,
          ),
        );
      },
    );
  }
}
