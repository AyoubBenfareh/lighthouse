import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class StarBurstOverlay extends StatelessWidget {
  const StarBurstOverlay({super.key, required this.visible});

  final bool visible;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: AnimatedOpacity(
        opacity: visible ? 1 : 0,
        duration: const Duration(milliseconds: 300),
        child: CustomPaint(
          size: Size.infinite,
          painter: _BurstPainter(),
        ),
      ),
    );
  }
}

class _BurstPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height * 0.35);
    final paint = Paint()..color = AppColors.warmGold;
    for (var i = 0; i < 12; i++) {
      final a = i * math.pi / 6;
      final p = center + Offset(math.cos(a), math.sin(a)) * 80;
      canvas.drawCircle(p, 6, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class BigKidButton extends StatelessWidget {
  const BigKidButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.color = AppColors.primaryViolet,
    this.icon,
  });

  final String label;
  final VoidCallback? onPressed;
  final Color color;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        disabledBackgroundColor: color.withValues(alpha: 0.4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 26),
            const SizedBox(width: 10),
          ],
          Flexible(child: Text(label, textAlign: TextAlign.center)),
        ],
      ),
    );
  }
}

class StarsXpBar extends StatelessWidget {
  const StarsXpBar({super.key, required this.stars, required this.xp});

  final int stars;
  final int xp;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w700,
          color: AppColors.darkText,
        );
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.royalPurple.withValues(alpha: 0.12),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.star_rounded, color: AppColors.warmGold, size: 28),
          const SizedBox(width: 6),
          Text('$stars', style: style),
          const SizedBox(width: 16),
          const Icon(Icons.bolt_rounded, color: AppColors.primaryViolet, size: 26),
          const SizedBox(width: 4),
          Text('$xp', style: style),
        ],
      ),
    );
  }
}
