import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import 'avatar_catalog.dart';

class AvatarPainter extends CustomPainter {
  AvatarPainter(this.def, {this.t = 0});

  final AvatarDef def;
  final double t;

  @override
  void paint(Canvas canvas, Size size) {
    final s = math.min(size.width, size.height);
    final c = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(
      c,
      s * 0.48,
      Paint()..color = def.primary.withValues(alpha: 0.18),
    );
    switch (def.kind) {
      case AvatarKind.explorer:
        _explorer(canvas, c, s);
      case AvatarKind.desertFox:
        _fox(canvas, c, s);
      case AvatarKind.bird:
        _bird(canvas, c, s);
      case AvatarKind.cat:
        _cat(canvas, c, s);
      case AvatarKind.starKid:
        _starKid(canvas, c, s);
      case AvatarKind.gardenExplorer:
        _garden(canvas, c, s);
    }
  }

  void _face(Canvas canvas, Offset c, double s, {Color? cheek}) {
    final bob = math.sin(t * math.pi * 2) * s * 0.01;
    final eyeY = c.dy - s * 0.02 + bob;
    for (final dx in [-0.08, 0.08]) {
      canvas.drawCircle(
        Offset(c.dx + s * dx, eyeY),
        s * 0.045,
        Paint()..color = AppColors.darkText,
      );
      canvas.drawCircle(
        Offset(c.dx + s * dx - s * 0.015, eyeY - s * 0.015),
        s * 0.015,
        Paint()..color = Colors.white,
      );
    }
    final cheekColor = cheek ?? AppColors.softPink.withValues(alpha: 0.7);
    for (final dx in [-0.16, 0.16]) {
      canvas.drawCircle(
        Offset(c.dx + s * dx, c.dy + s * 0.08),
        s * 0.035,
        Paint()..color = cheekColor,
      );
    }
    final smile = Path()
      ..moveTo(c.dx - s * 0.06, c.dy + s * 0.1)
      ..quadraticBezierTo(c.dx, c.dy + s * 0.16, c.dx + s * 0.06, c.dy + s * 0.1);
    canvas.drawPath(
      smile,
      Paint()
        ..color = AppColors.darkText
        ..style = PaintingStyle.stroke
        ..strokeWidth = s * 0.02
        ..strokeCap = StrokeCap.round,
    );
  }

  void _explorer(Canvas cnv, Offset c, double s) {
    cnv.drawCircle(c, s * 0.28, Paint()..color = const Color(0xFFFFE0B8));
    // scarf
    cnv.drawArc(
      Rect.fromCenter(center: c.translate(0, s * 0.12), width: s * 0.5, height: s * 0.3),
      0.2,
      math.pi - 0.4,
      false,
      Paint()
        ..color = def.accent
        ..style = PaintingStyle.stroke
        ..strokeWidth = s * 0.06,
    );
    // cap
    cnv.drawArc(
      Rect.fromCenter(center: c.translate(0, -s * 0.12), width: s * 0.5, height: s * 0.35),
      math.pi,
      math.pi,
      true,
      Paint()..color = def.primary,
    );
    _face(cnv, c, s);
  }

  void _fox(Canvas cnv, Offset c, double s) {
    final body = Path()
      ..moveTo(c.dx, c.dy + s * 0.28)
      ..lineTo(c.dx - s * 0.28, c.dy - s * 0.05)
      ..lineTo(c.dx - s * 0.12, c.dy - s * 0.3)
      ..lineTo(c.dx, c.dy - s * 0.12)
      ..lineTo(c.dx + s * 0.12, c.dy - s * 0.3)
      ..lineTo(c.dx + s * 0.28, c.dy - s * 0.05)
      ..close();
    cnv.drawPath(body, Paint()..color = def.primary);
    cnv.drawCircle(c, s * 0.14, Paint()..color = def.accent);
    _face(cnv, c, s * 0.9);
  }

  void _bird(Canvas cnv, Offset c, double s) {
    cnv.drawOval(
      Rect.fromCenter(center: c, width: s * 0.5, height: s * 0.42),
      Paint()..color = def.primary,
    );
    final wing = Path()
      ..moveTo(c.dx - s * 0.05, c.dy)
      ..quadraticBezierTo(c.dx - s * 0.35, c.dy - s * 0.05, c.dx - s * 0.15, c.dy + s * 0.15)
      ..close();
    cnv.drawPath(wing, Paint()..color = def.accent);
    // beak
    cnv.drawPath(
      Path()
        ..moveTo(c.dx + s * 0.18, c.dy)
        ..lineTo(c.dx + s * 0.32, c.dy + s * 0.02)
        ..lineTo(c.dx + s * 0.18, c.dy + s * 0.06)
        ..close(),
      Paint()..color = AppColors.warmGold,
    );
    _face(cnv, c.translate(-s * 0.04, 0), s * 0.85);
  }

  void _cat(Canvas cnv, Offset c, double s) {
    cnv.drawCircle(c, s * 0.26, Paint()..color = def.primary);
    for (final dx in [-1.0, 1.0]) {
      final ear = Path()
        ..moveTo(c.dx + dx * s * 0.12, c.dy - s * 0.18)
        ..lineTo(c.dx + dx * s * 0.22, c.dy - s * 0.36)
        ..lineTo(c.dx + dx * s * 0.02, c.dy - s * 0.22)
        ..close();
      cnv.drawPath(ear, Paint()..color = def.primary);
      cnv.drawPath(ear, Paint()..color = def.accent.withValues(alpha: 0.8));
    }
    _face(cnv, c, s);
  }

  void _starKid(Canvas cnv, Offset c, double s) {
    final path = Path();
    for (var i = 0; i < 10; i++) {
      final ang = -math.pi / 2 + i * math.pi / 5;
      final r = i.isEven ? s * 0.32 : s * 0.14;
      final p = Offset(c.dx + r * math.cos(ang), c.dy + r * math.sin(ang));
      if (i == 0) {
        path.moveTo(p.dx, p.dy);
      } else {
        path.lineTo(p.dx, p.dy);
      }
    }
    path.close();
    cnv.drawPath(path, Paint()..color = def.primary);
    cnv.drawCircle(c, s * 0.16, Paint()..color = Colors.white.withValues(alpha: 0.85));
    _face(cnv, c, s * 0.85);
  }

  void _garden(Canvas cnv, Offset c, double s) {
    cnv.drawCircle(c, s * 0.26, Paint()..color = const Color(0xFFFFE0B8));
    // leaf hat
    cnv.drawOval(
      Rect.fromCenter(center: c.translate(0, -s * 0.22), width: s * 0.36, height: s * 0.16),
      Paint()..color = def.primary,
    );
    cnv.drawOval(
      Rect.fromCenter(center: c.translate(s * 0.1, -s * 0.28), width: s * 0.14, height: s * 0.08),
      Paint()..color = def.accent,
    );
    _face(cnv, c, s);
  }

  @override
  bool shouldRepaint(covariant AvatarPainter oldDelegate) =>
      oldDelegate.def != def || oldDelegate.t != t;
}

class AvatarBadge extends StatelessWidget {
  const AvatarBadge({
    super.key,
    required this.index,
    this.size = 72,
    this.t = 0,
    this.selected = false,
  });

  final int index;
  final double size;
  final double t;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final def = AvatarDef.all[index.clamp(0, AvatarDef.all.length - 1)];
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: selected ? AppColors.royalPurple : Colors.white,
          width: selected ? 3.5 : 2,
        ),
        boxShadow: [
          BoxShadow(
            color: def.primary.withValues(alpha: 0.35),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: CustomPaint(painter: AvatarPainter(def, t: t)),
    );
  }
}
