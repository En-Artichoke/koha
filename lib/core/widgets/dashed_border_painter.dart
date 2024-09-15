import 'package:flutter/material.dart';

class DashedBorderPainter extends CustomPainter {
  final bool allSides;
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;

  DashedBorderPainter({
    this.allSides = false,
    this.color = Colors.grey,
    this.strokeWidth = 1,
    this.dashWidth = 5,
    this.dashSpace = 3,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    void drawDashedLine(Offset start, Offset end) {
      final path = Path()..moveTo(start.dx, start.dy);

      final dashCount =
          ((end - start).distance / (dashWidth + dashSpace)).floor();

      for (var i = 0; i < dashCount; i++) {
        final startX = start.dx + (dashWidth + dashSpace) * i;
        final endX = startX + dashWidth;
        path.moveTo(startX, start.dy);
        path.lineTo(endX, start.dy);
      }

      canvas.drawPath(path, paint);
    }

    // Top border
    drawDashedLine(Offset.zero, Offset(size.width, 0));

    // Bottom border
    drawDashedLine(Offset(0, size.height), Offset(size.width, size.height));

    if (allSides) {
      // Left border
      drawDashedLine(Offset.zero, Offset(0, size.height));

      // Right border
      drawDashedLine(Offset(size.width, 0), Offset(size.width, size.height));
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
