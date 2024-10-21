import 'package:flutter/material.dart';
import 'package:pmc/src/Views/Utilies/images.dart';
import 'package:pmc/src/Views/Utilies/sizedbox_widget.dart';
import 'package:pmc/src/Views/Widget/custom_drawpage.dart';
import 'package:pmc/src/Views/Widget/onboard_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body:SingleChildScrollView(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24,horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                    Padding(
                        padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width / 14,
                        right: MediaQuery.of(context).size.width /14 ),
                        child: Image.asset(AppImages.logo, 
                       ),
                      ),
                16.vspace,
                 const OnBoardText(text: 'Hello! John Doe', color: Colors.white),
                 16.vspace,
                CommonHomeWidget(width: MediaQuery.of(context).size.width, 
                text: 'Plan Name', text1: 'GOLD'),
                16.vspace,
                CommonHomeWidget(width: MediaQuery.of(context).size.width, 
                text: 'Course Generated', text1: '05/20'),
                16.vspace,
                CommonHomeWidget(width: MediaQuery.of(context).size.width, 
                text: 'Plan Expiry', text1: '22-05-2024'),
               
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}

class CommonHomeWidget extends StatelessWidget {
  final double width;
  final double? height;
  final String text;
  final String text1;
  const CommonHomeWidget({super.key, required this.width, this.height, required this.text, required this.text1});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: CustomDrawPage(const Color.fromRGBO(139, 175, 76, 1),
      Colors.white, const Color.fromRGBO(139, 175, 76, 1)),
      child: Container(
        padding: const EdgeInsets.all(16),
        height: height,
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(text,style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Colors.black,
            ),),
            Text(text1,style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),),  
          ],
        ),
      ),
    );
  }
}