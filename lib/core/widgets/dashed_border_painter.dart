import 'package:flutter/material.dart';

class DashedBorderPainter extends CustomPainter {
  final bool allSides;
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;
  final bool bottomOnly;
  final bool leftAndRight;
  final bool topAndBottom;
  final bool topOnly;

  DashedBorderPainter({
    this.allSides = false,
    this.color = Colors.white70,
    this.strokeWidth = 1,
    this.dashWidth = 5,
    this.dashSpace = 3,
    this.bottomOnly = false,
    this.leftAndRight = false,
    this.topAndBottom = false,
    this.topOnly = false,
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

    if (bottomOnly) {
      drawDashedLine(Offset(0, size.height), Offset(size.width, size.height));
    }
    if (topOnly) {
      // New condition for top border only
      drawDashedLine(Offset.zero, Offset(size.width, 0));
    }
    if (allSides) {
      // Top border
      drawDashedLine(Offset.zero, Offset(size.width, 0));

      // Bottom border
      drawDashedLine(Offset(0, size.height), Offset(size.width, size.height));

      // Left border
      drawDashedLine(Offset.zero, Offset(0, size.height));

      // Right border
      drawDashedLine(Offset(size.width, 0), Offset(size.width, size.height));
    }

    if (topAndBottom) {
      // Top border
      drawDashedLine(Offset.zero, Offset(size.width, 0));

      // Bottom border
      drawDashedLine(Offset(0, size.height), Offset(size.width, size.height));
    }

    if (leftAndRight) {
      // Left border
      drawDashedLine(Offset.zero, Offset(0, size.height));

      // Right border
      drawDashedLine(Offset(size.width, 0), Offset(size.width, size.height));
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
