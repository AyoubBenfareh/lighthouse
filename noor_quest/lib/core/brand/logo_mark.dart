import 'package:flutter/material.dart';

/// App logo — prefer asset; fall back to CustomPaint mark.
class LogoMark extends StatelessWidget {
  const LogoMark({
    super.key,
    this.size = 96,
    this.showWordmark = false,
    this.title = 'Noor Quest',
    this.subtitle,
  });

  final double size;
  final bool showWordmark;
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final mark = Image.asset(
      'assets/brand/logo_192.png',
      width: size,
      height: size,
      filterQuality: FilterQuality.high,
      errorBuilder: (context, error, stackTrace) => CustomPaint(
        size: Size.square(size),
        painter: _FallbackLogoPainter(),
      ),
    );

    if (!showWordmark) return mark;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        mark,
        const SizedBox(height: 10),
        Text(
          title,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w800,
                color: const Color(0xFF5636A7),
              ),
        ),
        if (subtitle != null)
          Text(
            subtitle!,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleMedium,
          ),
      ],
    );
  }
}

class _FallbackLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final c = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(c, size.width * 0.4, Paint()..color = const Color(0xFFF2C66D));
    canvas.drawCircle(c, size.width * 0.22, Paint()..color = Colors.white);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
