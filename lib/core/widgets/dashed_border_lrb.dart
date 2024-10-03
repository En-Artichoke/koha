import 'dart:ui';

import 'package:flutter/material.dart';

class DashedBorderLRB extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;
  final double padding;
  final double cornerGap;

  DashedBorderLRB({
    this.color = Colors.white70,
    this.strokeWidth = 1,
    this.dashWidth = 5,
    this.dashSpace = 3,
    this.padding = 8,
    this.cornerGap = 10,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final adjustedSize = Size(
      size.width - (padding * 2),
      size.height - (padding * 2),
    );

    void drawDashedLine(Offset start, Offset end) {
      final path = Path();
      final dashCount =
          ((end - start).distance / (dashWidth + dashSpace)).floor();

      for (var i = 0; i < dashCount; i++) {
        final startFraction = i / dashCount;
        final endFraction =
            (i + dashWidth / (dashWidth + dashSpace)) / dashCount;
        final startPoint = Offset.lerp(start, end, startFraction)!;
        final endPoint = Offset.lerp(start, end, endFraction)!;
        path.moveTo(startPoint.dx, startPoint.dy);
        path.lineTo(endPoint.dx, endPoint.dy);
      }

      canvas.drawPath(path, paint);
    }

    // Left border
    drawDashedLine(
      Offset(padding, padding),
      Offset(padding, adjustedSize.height + padding - cornerGap),
    );

    // Right border
    drawDashedLine(
      Offset(adjustedSize.width + padding, padding),
      Offset(adjustedSize.width + padding,
          adjustedSize.height + padding - cornerGap),
    );

    // Bottom border
    drawDashedLine(
      Offset(padding + cornerGap, adjustedSize.height + padding),
      Offset(adjustedSize.width + padding - cornerGap,
          adjustedSize.height + padding),
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
