import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmc/src/Views/Routes/route_name.dart';
import 'package:pmc/src/Views/Utilies/images.dart';
import 'package:pmc/src/Views/Utilies/sizedbox_widget.dart';
import 'package:pmc/src/Views/Widget/button_widget.dart';
import 'package:pmc/src/Views/Widget/onboard_text.dart';
import 'package:pmc/src/Views/Widget/phonefield_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phone = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
          margin:const EdgeInsets.only(top: 36,left: 4,right: 4,bottom: 8),
        padding:const EdgeInsets.all(16),
        decoration:const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.background),
            fit: BoxFit.fill
            ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Padding(
                padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width / 14,
                right: MediaQuery.of(context).size.width /14 ),
                child: Image.asset(AppImages.logo, 
               ),
              ),
              24.vspace,
              Center(child:  Text('Login',style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Colors.white,
              ),)),
             16.vspace,
            const OnBoardText(text: 'Enter Phone number', color: Colors.white),
            16.vspace,
              PhoneNumberField(
                height: 66, 
                width: MediaQuery.of(context).size.width / 1.15, 
                topsize: 15, 
                textEditingController: phone, hintText: 'Enter your phone', hintColor: Colors.white),
            SizedBox(
              height: MediaQuery.of(context).size.height / 2,
            ),
            Padding(
              padding:  EdgeInsets.only(left:MediaQuery.of(context).size.width / 8,right: MediaQuery.of(context).size.width / 14),
              child: CommonButtonWidget(
                text: 'Continue', 
                height: 56, 
                width: MediaQuery.of(context).size.width, 
                fillColor: Colors.yellow,
                borderColor: Colors.white, 
                shadowColor: Colors.yellow, 
                textColor: Colors.black, onPressed: (){
                  Get.toNamed(Appnames.loginotp);
                }),
            )
            ],
          ),
        ),
      ),
    );
  }
}