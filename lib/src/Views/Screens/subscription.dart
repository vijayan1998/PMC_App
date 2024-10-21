import 'package:flutter/material.dart';
import 'package:pmc/src/Views/Utilies/images.dart';
import 'package:pmc/src/Views/Utilies/sizedbox_widget.dart';
import 'package:pmc/src/Views/Widget/onboard_text.dart';
import 'package:pmc/src/Views/Widget/subscription_widget.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Container(
            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 22,left: 4,right: 4,),
            padding:const EdgeInsets.all(8),
            decoration:const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.background1),
                fit: BoxFit.fill,
                ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 16),
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
                12.vspace,
               const OnBoardText(text: 'Select your Subscription', color: Colors.white),
               16.vspace,
                SubscriptionWidget(
                  width: MediaQuery.of(context).size.width, 
                  text1: 'Free', 
                  text2: '₹ 0.00', 
                  text3: 'Generate 1 free Course', 
                  text4: 'Up to 5 Subtopics', 
                  text5: 'AI Teacher', 
                  text7: 'Theory & Image Course',
                  text6: 'Video & Image Course',),
                16.vspace,
                SubscriptionWidget(
                  width: MediaQuery.of(context).size.width, 
                  text1: 'Gold', 
                  text2: '₹ 100/Month', 
                  text3: 'Generate 3 free Course', 
                  text4: 'Up to 10 Subtopics', 
                  text5: 'AI Teacher', 
                  text6: 'Video & Image Course',
                  text7: 'Theory & Image Course'),
                16.vspace,
                SubscriptionWidget(
                  width: MediaQuery.of(context).size.width, 
                  text1: 'Platinum', 
                  text2: '₹ 200/Month', 
                  text3: 'Generate 20 free Course', 
                  text4: 'Up to 10 Subtopics', 
                  text5: 'AI Teacher', 
                  text6: 'Video & Image Course',
                  text7: 'Theory & Image Course'),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 14,
                  )
                ],
              ),
            ),
        ),
      ),
    );
  }
}