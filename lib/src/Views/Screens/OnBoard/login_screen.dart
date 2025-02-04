import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmc/src/Controller/signup_controller.dart';
import 'package:pmc/src/Controller/subscription_controller.dart';
import 'package:pmc/src/Views/Routes/route_name.dart';
import 'package:pmc/src/Views/Utilies/images.dart';
import 'package:pmc/src/Views/Utilies/sizedbox_widget.dart';
import 'package:pmc/src/Views/Widget/bottom_widget.dart';
import 'package:pmc/src/Views/Widget/gradient_button.dart';
import 'package:pmc/src/Views/Widget/onboard_text.dart';
import 'package:pmc/src/Views/Widget/phonefield_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phone = TextEditingController();
  SignupController signupController = Get.put(SignupController());
  SubscriptionController subscriptionController =
      Get.put(SubscriptionController());
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    subscriptionController.getUserLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      // color:const Color(0xff300080),
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(AppImages.background2), fit: BoxFit.fill),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: 48,
                      left: MediaQuery.of(context).size.width / 14,
                      right: MediaQuery.of(context).size.width / 14),
                  child: Image.asset(
                    AppImages.logo,
                  ),
                ),
                24.vspace,
                Center(
                    child: Text(
                  'Login',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Colors.white,
                      ),
                )),
                36.vspace,
                const OnBoardText(text: 'Phone', color: Colors.white),
                16.vspace,
                PhoneNumberField(
                    textEditingController: phone,
                    hintText: 'Enter phone',
                    hintColor: Colors.grey.shade800),
                48.vspace,
                Center(
                  child: GradientButtonWidget(
                    text:'Continue',
                    width: 200,
                    isWaiting: isLoading,
                    onTap: () async {
                      if (phone.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Please Enter your phone number.")),
                        );
                      } else {
                        if(isLoading) return;
                        setState(() {
                          isLoading = true;
                        });
                        await Future.delayed(const Duration(seconds: 2),(){
                            signupController.userVerifyPhone(phone.text);
                        Get.toNamed(Appnames.loginotp, arguments: phone.text);
                        });
                        setState(() {
                          isLoading = false;
                        });
                      }
                    },
                  ),
                ),
                36.vspace,
                const Center(
                    child: OnBoardText(
                        text: 'Don’t have an account?', color: Colors.white)),
                36.vspace,
                Center(
                    child: InkWell(
                        onTap: () {
                          Get.toNamed(Appnames.register);
                        },
                        child: const OnBoardText(
                            text: ' Create an account', color: Colors.white))),
                24.vspace,
              ],
            ),
          ),
          bottomNavigationBar: const BottomWidget()),
    );
  }
}
