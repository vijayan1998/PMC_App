import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:pmc/src/Views/Routes/route_name.dart';
import 'package:pmc/src/Views/Utilies/images.dart';
import 'package:pmc/src/Views/Utilies/sizedbox_widget.dart';
import 'package:pmc/src/Views/Widget/button_widget.dart';
import 'package:pmc/src/Views/Widget/onboard_text.dart';

class LoginOtpScreen extends StatefulWidget {
  const LoginOtpScreen({super.key});

  @override
  State<LoginOtpScreen> createState() => _LoginOtpScreenState();
}

class _LoginOtpScreenState extends State<LoginOtpScreen> {
    final  pinputController = TextEditingController();
    final focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
     final defaultPinTheme = PinTheme(
      width: 76,
      height: 76,
      textStyle: const TextStyle(
        fontSize: 24,
        color:Colors.white,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: const Color.fromRGBO(188, 240, 105, 1),
        border: Border.all(color: Colors.white,width: 2),
      ),
    );
    const focusedBorderColor = Colors.white;
    const fillColor = Color.fromRGBO(188, 240, 105, 1);
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 22,left: 4,right: 4),
      padding:const EdgeInsets.all(8),
      decoration:const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImages.background),
          fit: BoxFit.fill
          ),
      ),
      child: SingleChildScrollView(
        child: Padding(
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
            const Center(
                child: OnBoardText(text: 'Phone Number Verification', color: Colors.white),
              ),
              24.vspace,
              Material(
                color: Colors.transparent,
                child: Pinput(
                    controller: pinputController,
                    focusNode: focusNode,
                    length: 6,
                    defaultPinTheme: defaultPinTheme,
                    focusedPinTheme: defaultPinTheme.copyWith(
                    decoration: defaultPinTheme.decoration!.copyWith(
                      border: Border.all(color: focusedBorderColor),
                    ),
                  ),
                  submittedPinTheme: defaultPinTheme.copyWith(
                    decoration: defaultPinTheme.decoration!.copyWith(
                      color: fillColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: focusedBorderColor),
                    ),
                  ),
                  errorPinTheme: defaultPinTheme.copyBorderWith(
                    border: Border.all(color: Colors.redAccent),
                  ),
                  onSubmitted: (value){ 
                  }, 
                  ),
              ),
              24.vspace,
              Text('We have sent you an OTP (one time password) to your phone number',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Colors.white),
              textAlign: TextAlign.center,),
              24.vspace,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CommonButtonWidget(
                    text: 'Resend OTP', 
                    height: 56, 
                    width: MediaQuery.of(context).size.width / 2.5, 
                    fillColor: fillColor, 
                    borderColor: Colors.white,
                     shadowColor: fillColor, 
                     textColor: Colors.black,
                      onPressed: (){
                      }),
                    16.hspace,
                    const OnBoardText(text: '90 Sec', color: Colors.white)
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 4,
              ),
              Padding(
                padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width / 8,right: MediaQuery.of(context).size.width / 16),
                child: CommonButtonWidget(
                  text: 'Continue', 
                  height: 56, 
                  width: MediaQuery.of(context).size.width, 
                  fillColor: Colors.yellow, 
                  borderColor: Colors.white, 
                  shadowColor: Colors.white, 
                  textColor: Colors.black, 
                  onPressed: (){
                    Get.toNamed(Appnames.subscription);
                  }),
              ),
              24.vspace,
            ],
          ),
        ),
      ),
    );
  }
}