import 'dart:math';
import 'package:flutter/material.dart';

class DashedCirclePainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashSize;
  final double gapSize;

  DashedCirclePainter({
    this.color = Colors.white,
    this.strokeWidth = 1,
    this.dashSize = 3,
    this.gapSize = 3,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) / 2;

    final dashCount = (2 * pi * radius / (dashSize + gapSize)).round();
    final dashAngle = 2 * pi / dashCount;

    for (var i = 0; i < dashCount; i++) {
      final startAngle = i * dashAngle;
      final endAngle = startAngle + (dashSize / radius);

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        endAngle - startAngle,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
