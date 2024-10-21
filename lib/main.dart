import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pmc/src/Views/Routes/routes_page.dart';
import 'package:pmc/src/Views/Screens/onboarding.dart';
import 'package:pmc/src/Views/Utilies/theme.dart';

void main() {
   SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitDown,DeviceOrientation.portraitUp]
  );
  SystemChrome.setSystemUIOverlayStyle( const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'PickMyCourse',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme:AppTheme.lightTheme,  
       getPages: AppRoutes.appRoutes(),
        defaultTransition: Transition.leftToRightWithFade,
      home: const OnboardingScreen(),
    );
  }
}


class RectanglePaintPage extends StatelessWidget {
  final Color fillColor;

 const RectanglePaintPage({super.key, required this.fillColor});

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.black,
        body: Center(
          child: Column(
            children: [
              CustomPaint(
                painter: RectanglePainter(fillColor,Colors.white),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: MediaQuery.of(context).size.height / 6,
                  child: const Text('Hello World'),
                ),
              ), 
            
            ],
          ),
        ),
      );
}

class RectanglePainter extends CustomPainter {
  final Color fillColor;
  final Color borderColor;

  RectanglePainter(this.fillColor,this.borderColor);

  @override
  void paint(Canvas canvas, Size size) {
    // Draw shadow
    final shadowPaint = Paint()
      ..color = Colors.blue// Shadow color with opacity
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
    path.lineTo(size.width - 40, 0); // Draw to the top-right corner, leaving 40px gap
    path.lineTo(size.width, 40); // Create a slanted line for the top-right corner
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

// class RectanglePaintPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) => Scaffold(
//         body: Center(
//           child: CustomPaint(
//             painter: RectanglePainter(Colors.blue),
//             child: Container(
//               width: MediaQuery.of(context).size.width / 1.2,
//               height: MediaQuery.of(context).size.height / 6,
//               decoration: BoxDecoration(
//                 color: Colors.transparent, // Make the background transparent since CustomPainter will fill it
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.blue.withOpacity(0.5),
//                     spreadRadius: 5,
//                     blurRadius: 7,
//                     offset: Offset(0, 3), // Shadow position
//                   ),
//                 ],
//               ),
//               // child: CustomPaint(
//               //   painter: RectanglePainter(),
//               //   // child: Text(
//               //   //   "Custom Paint",
//               //   //   style: TextStyle(fontSize: 30, fontStyle: FontStyle.italic),
//               //   // ),
//               // ),
//             ),
//           ),
//         ),
//       );
// }

// class RectanglePainter extends CustomPainter {
//   final Color fillColor;
// RectanglePainter(this.fillColor);

//   @override
//   void paint(Canvas canvas, Size size) {
//     // Fill Paint
//     final fillPaint = Paint()
//       ..color = fillColor // Fill color for the rectangle
//       ..style = PaintingStyle.fill;

//     // Border Paint
//     final borderPaint = Paint()
//       ..color = Colors.black
//       ..strokeWidth = 3
//       ..style = PaintingStyle.stroke;

//     // Draw the path (shape)
//     final Path path = Path();
//     path.moveTo(0, 0); // Start at top-left corner
//     path.lineTo(size.width - 40, 0); // Draw to the top-right corner, leaving 40px gap
//     path.lineTo(size.width, 40); // Create a slanted line for the top-right corner
//     path.lineTo(size.width, size.height); // Line to the bottom-right
//     path.lineTo(0, size.height); // Line to the bottom-left corner
//     path.close(); // Close the path (goes back to top-left)

//     // Fill the shape
//     canvas.drawPath(path, fillPaint);
    
//     // Draw the border
//     canvas.drawPath(path, borderPaint);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => false;
// }

