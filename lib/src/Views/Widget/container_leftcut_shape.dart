import 'package:flutter/material.dart';

class ContainerLeftCutShape extends StatelessWidget {
  final double containerHeight;
  final double containerWidth;
  final Color containerColor;
  final double shadowBlurRadius;
  final double shadowSpreadRadius;
  final Offset shadowOffset;
  final Color shadowColor;
  final Widget widget;

  const ContainerLeftCutShape({
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
    return CustomPaint(
      painter: CutShadowPainter(
        shadowBlurRadius: shadowBlurRadius,
        shadowColor: shadowColor,
        shadowOffset: shadowOffset,
      ),
      child: ClipPath(
        clipper: TopLeftCornerClipper(),
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
                child: SingleChildScrollView(child: widget),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Custom Clipper to cut the top-left corner
class TopLeftCornerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(70, 0); // Start with the top-left cut
    path.lineTo(size.width, 0); // Move to top-right
    path.lineTo(size.width, size.height); // Move to bottom-right
    path.lineTo(0, size.height); // Move to bottom-left
    path.lineTo(0, 70); // Draw the diagonal cut at top-left
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
    path.moveTo(70, 0); // Start from top-left after the cut
    path.lineTo(size.width, 0); // Move to top-right
    path.lineTo(size.width, size.height); // Move to bottom-right
    path.lineTo(0, size.height); // Move to bottom-left
    path.lineTo(0, 70); // Draw the diagonal cut at top-left
    path.close(); // Complete the shape

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
    shadowPath.moveTo(70, 0); // Start from the top-left cut
    shadowPath.lineTo(size.width, 0); // Move to top-right
    shadowPath.lineTo(size.width, size.height); // Move to bottom-right
    shadowPath.lineTo(0, size.height); // Move to bottom-left
    shadowPath.lineTo(0, 70); // Draw the diagonal cut at top-left
    shadowPath.close(); // Complete the shape

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
