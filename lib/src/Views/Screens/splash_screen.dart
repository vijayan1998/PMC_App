import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmc/src/Views/Routes/route_name.dart';
import 'package:pmc/src/Views/Screens/onboarding.dart';
import 'package:pmc/src/Views/Utilies/sizedbox_widget.dart';
import 'package:pmc/src/Views/Widget/button_widget.dart';
import 'package:pmc/src/Views/Widget/common_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:const Color(0xff17202a),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 46,horizontal: 16),
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Center(
                   child: Text('PickMyCourse',style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                    ),
                    textAlign: TextAlign.center,
                    ),
                 ),
                  Center(
                    child: Text('Create Your Course,Your Way',style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                    ),
                  ),
                36.vspace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonContainer(fillColor:const Color(0xff17202a), 
                    text: 'Discover the future of learning with Pick My Course. Our  AI-Powered platform creates engaging courses tailored to your needs. Unlock your full potential today!', 
                    borderColor: Colors.white, 
                    height:MediaQuery.of(context).size.height / 8,
                    width: MediaQuery.of(context).size.width / 1.3,
                    shadowColor: Colors.green.withOpacity(0.55)),
                    24.vspace,
                    Row(
                      children: [
                        CommonButtonWidget(
                          text: 'Login',
                          height: MediaQuery.of(context).size.height / 18, 
                          width: MediaQuery.of(context).size.width / 2.7, 
                          fillColor: Colors.green, 
                          borderColor: Colors.white,
                          textColor: Colors.black, 
                          shadowColor: Colors.green,
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const OnboardingScreen()));
                            // Get.toNamed(Appnames.login);
                          },
                          ),
                          16.hspace,
                     CommonButtonWidget(
                      text: 'Signup',
                      height: MediaQuery.of(context).size.height / 18, 
                      width: MediaQuery.of(context).size.width / 2.7, 
                      fillColor: Colors.yellow, 
                      borderColor: Colors.white,
                      textColor: Colors.black, 
                      shadowColor: Colors.yellow,
                      onPressed: (){
                        Get.toNamed(Appnames.register);
                      },
                      ),
                      ],
                    ),
                    ],
                    ),
                    
                  ],
                ),
              ],
            ),
           
          ],
        ),
      ),
    );
  }
}