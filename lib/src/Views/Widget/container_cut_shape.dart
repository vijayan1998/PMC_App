import 'dart:ui';

import 'package:flutter/material.dart';

class ContainerCutShape extends StatelessWidget {
  final double containerHeight;
  final double containerWidth;
  final Color containerColor;
  final double shadowBlurRadius;
  final double shadowSpreadRadius;
  final Offset shadowOffset;
  final Color shadowColor;
  final Widget widget;

  const ContainerCutShape({
    super.key,
    required this.containerHeight,
    required this.containerWidth,
    required this.containerColor,
    required this.shadowBlurRadius,
    required this.shadowSpreadRadius,
    required this.shadowOffset,
    required this.shadowColor,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: CustomPaint(
        painter: CutShadowPainter(
          shadowBlurRadius: shadowBlurRadius,
          shadowColor: shadowColor,
          shadowOffset: shadowOffset,
        ),
        child: ClipPath(
          clipper: TopRightCornerClipper(),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
            child: Container(
              height: containerHeight,
              width: containerWidth,
              decoration: BoxDecoration(
                color: containerColor, // Background color of the clipped container
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: CustomPaint(
                      painter: BorderPainter(), // Custom painter for the border
                    ),
                  ),
                  Positioned.fill(
                    child: widget,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Custom Clipper to cut the top-right corner
class TopRightCornerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, 0); // Start from the top-left corner
    path.lineTo(size.width - 20, 0); // Cut the top-right corner
    path.lineTo(size.width, 20); // Diagonal line for the corner
    path.lineTo(size.width, size.height); // Go down to the bottom-right
    path.lineTo(0, size.height); // Move to the bottom-left corner
    path.close(); // Close the path
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

// Custom painter to draw the border
class BorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke;

    final Path path = Path();
    path.moveTo(0, 0); // Start from top-left
    path.lineTo(size.width - 20, 0); // Move to the near top-right corner
    path.lineTo(size.width, 20); // Draw the diagonal cut
    path.lineTo(size.width, size.height); // Move to the bottom-right
    path.lineTo(0, size.height); // Move to bottom-left corner
    path.close(); // Complete the rectangle with a cut corner

    canvas.drawPath(path, paint); // Draw the border
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Custom painter to handle shadow for diagonal cut
class CutShadowPainter extends CustomPainter {
  final double shadowBlurRadius;
  final Color shadowColor;
  final Offset shadowOffset;

  CutShadowPainter({
    required this.shadowBlurRadius,
    required this.shadowColor,
    required this.shadowOffset,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Path shadowPath = Path();
    shadowPath.moveTo(0, 0); // Start from top-left
    shadowPath.lineTo(size.width - 23, 0); // Near top-right
    shadowPath.lineTo(size.width, 23); // Diagonal cut corner
    shadowPath.lineTo(size.width, size.height); // Move to bottom-right
    shadowPath.lineTo(0, size.height); // Move to bottom-left
    shadowPath.close();

    final Paint shadowPaint = Paint()
      ..color = shadowColor
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, shadowBlurRadius);

    // Apply shadow offset
    canvas.save();
    canvas.translate(shadowOffset.dx, shadowOffset.dy);
    canvas.drawPath(shadowPath, shadowPaint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
