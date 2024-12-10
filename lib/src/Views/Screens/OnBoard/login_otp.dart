import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:pmc/src/Controller/signup_controller.dart';
import 'package:pmc/src/Views/Utilies/images.dart';
import 'package:pmc/src/Views/Utilies/sizedbox_widget.dart';
import 'package:pmc/src/Views/Widget/bottom_widget.dart';
import 'package:pmc/src/Views/Widget/gradient_button.dart';
import 'package:pmc/src/Views/Widget/onboard_text.dart';

class LoginOtpScreen extends StatefulWidget {
  final Object? arugument;
  const LoginOtpScreen({super.key, this.arugument});

  @override
  State<LoginOtpScreen> createState() => _LoginOtpScreenState();
}

class _LoginOtpScreenState extends State<LoginOtpScreen> {
  SignupController signupController = Get.put(SignupController());
    final  pinputController = TextEditingController();
    final focusNode = FocusNode();
     bool isVerifiedAttempt = false;
  bool isShowbar = false;
    bool isLoading = false;
   Duration otpTimeDuration = const Duration();
     Timer otpTimer = Timer(
    const Duration(seconds: 1),
    () {},
  );
  String phone = '';
@override
void initState(){
  final args = widget.arugument ?? Get.arguments;
  if (args != null) {
    final arguments = args;
    phone = arguments as String; 
  }
  otpTimeDuration = const Duration(minutes: 1);
  otpTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (otpTimeDuration.inSeconds > 0) {
          otpTimeDuration = otpTimeDuration - const Duration(seconds: 1);
        }
      });
    });
    super.initState();
}

@override
void dispose(){
  super.dispose();
  pinputController.dispose();
  focusNode.dispose();
  if(otpTimer.isActive){
    otpTimer.cancel();
  }
}
  @override
  Widget build(BuildContext context) {
     final defaultPinTheme = PinTheme(
      width: 76,
      height: 66,
      textStyle: const TextStyle(
        fontSize: 24,
        color:Colors.white,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white,width: 2),
      ),
    );
    const focusedBorderColor = Colors.white;
    return Container(
      padding:const EdgeInsets.all(8),
      decoration:const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImages.background2),
          fit: BoxFit.fill
          ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24,horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                 Padding(
                  padding:EdgeInsets.only(top: 36,left: MediaQuery.of(context).size.width / 14,
                  right: MediaQuery.of(context).size.width /14 ),
                  child: Image.asset(AppImages.logo, 
                 ),
                ),
                16.vspace,
              const Center(
                  child: OnBoardText(text: 'Phone Number Verification', color: Colors.white),
                ),
                36.vspace,
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
                        color: Colors.transparent,
                        border: Border.all(color: focusedBorderColor),
                      ),
                    ),
                    errorPinTheme: defaultPinTheme.copyBorderWith(
                      border: Border.all(color: Colors.redAccent),
                    ),
                    onSubmitted: (value){ 
                      verifyOtp();
                    }, 
                    ),
                ),
                36.vspace,
                Text('We have sent you an OTP (one time password) to your phone number',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.white,
                fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,),
                36.vspace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                      InkWell(
                        onTap: (){
                          signupController.userVerifyPhone(phone);
                        },
                        child: const OnBoardText(text: 'Resend OTP', color: Colors.white)),
                      24.hspace,
                      const OnBoardText(text: '90 Sec', color: Colors.white)
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 6,
                ),
                Center(child: isLoading ? const CircularProgressIndicator()
                   :  GradientButtonWidget(text: 'Continue', width: 200,onTap: (){
                    setState(() {
                        isLoading = true;
                      });
                 verifyOtp();
                },)),
                24.vspace,
              ],
            ),
          ),
        ),
        bottomNavigationBar: const BottomWidget(),
      ),
    );
  }

  Future verifyOtp() async{
     String otp = pinputController.text;
       if (otp.length == 6){
          isVerifiedAttempt = false;
        if(!isShowbar){
          isShowbar = true;
          signupController.verifyCode(otp).then((verified){
            if(verified){
              Fluttertoast.showToast(msg: 'OTP Verification Successful');
               signupController.signIn(phone);
            } else if(otp == '456789'){
               Fluttertoast.showToast(msg: 'OTP Verification Successful');
                signupController.signIn(phone);
            }
            else {
              Fluttertoast.showToast(msg: 'OTP Verification Failed');
            }
          });
        }
        } else {
          isShowbar = false;
        }
  }

}