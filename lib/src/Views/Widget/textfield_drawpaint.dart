import 'package:flutter/material.dart';

class RectanglePainter extends CustomPainter {
  final Color fillColor;
  final double topsize;
  RectanglePainter(this.fillColor, this.topsize);

  @override
  void paint(Canvas canvas, Size size) {
    // Shadow Paint (for the shadow effect)
    final shadowPaint = Paint()
      ..color = fillColor // Shadow color with some opacity
      ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 15) // Apply blur effect
      ..style = PaintingStyle.fill;

    

    // Border Paint
    final borderPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    // Draw the path (shape)
    final Path path = Path();
    path.moveTo(0, 0); // Start at top-left corner
    path.lineTo(size.width - topsize, 0); // Draw to the top-right corner, leaving 40px gap
    path.lineTo(size.width, topsize); // Create a slanted line for the top-right corner
    path.lineTo(size.width, size.height); // Line to the bottom-right
    path.lineTo(0, size.height); // Line to the bottom-left corner
    path.close(); // Close the path (goes back to top-left)

    // Draw the shadow (before the border to appear behind)
    canvas.drawPath(path, shadowPaint);

    // Draw the border
    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}