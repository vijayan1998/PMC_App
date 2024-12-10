import 'package:flutter/material.dart';

class CommonContainer extends StatelessWidget {
  final Color fillColor;
  final String text;
  final Color borderColor;
  final Color shadowColor;
  final double? height;
  final double width;

 const CommonContainer({super.key, required this.fillColor, required this.text, required this.borderColor, required this.shadowColor, this.height, required this.width});

  @override
  Widget build(BuildContext context) => CustomPaint(
          painter: RectanglePainter(fillColor,borderColor,shadowColor),
          child: Container(
            padding: const EdgeInsets.all(8),
            width: width,
            height: height,
            child: Text(text,style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: Colors.white,
              fontSize: 18,
            ),),
          ),
        );
}

class RectanglePainter extends CustomPainter {
  final Color fillColor;
  final Color borderColor;
  final Color shadowColor;

  RectanglePainter(this.fillColor,this.borderColor, this.shadowColor);

  @override
  void paint(Canvas canvas, Size size) {
    // Draw shadow
    final shadowPaint = Paint()
      ..color =  shadowColor  // Shadow color with opacity
      ..maskFilter =const MaskFilter.blur(BlurStyle.normal, 12) // Shadow blur
      ..style = PaintingStyle.fill; // Fill for shadow

    // Shadow path, slightly offset from the original shape
    final shadowPath = Path();
    shadowPath.moveTo(5, 5); // Slightly offset from the top-left
    shadowPath.lineTo(size.width - 35, 10); // Offset right side
    shadowPath.lineTo(size.width - 5, 45); // Offset top-right
    shadowPath.lineTo(size.width - 5, size.height + 5); // Offset bottom-right
    shadowPath.lineTo(5, size.height + 5); // Offset bottom-left
    shadowPath.close();

    // Draw the shadow
    canvas.drawPath(shadowPath, shadowPaint);

    // Fill Paint
    final fillPaint = Paint()
      ..color = fillColor // Use the passed fill color
      ..style = PaintingStyle.fill;

    // Border Paint
    final borderPaint = Paint()
      ..color = borderColor
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    // Draw the actual path (shape)
    final Path path = Path();
    path.moveTo(0, 0); // Start at top-left corner
    path.lineTo(size.width - 30, 0); // Draw to the top-right corner, leaving 40px gap
    path.lineTo(size.width, 30); // Create a slanted line for the top-right corner
    path.lineTo(size.width, size.height); // Line to the bottom-right
    path.lineTo(0, size.height); // Line to the bottom-left corner
    path.close(); // Close the path (goes back to top-left)

    // Fill the shape
    canvas.drawPath(path, fillPaint);

    // Draw the border
    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}