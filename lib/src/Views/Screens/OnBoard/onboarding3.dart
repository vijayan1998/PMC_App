import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmc/src/Views/Routes/route_name.dart';
import 'package:pmc/src/Views/Utilies/images.dart';
import 'package:pmc/src/Views/Utilies/sizedbox_widget.dart';
import 'package:pmc/src/Views/Widget/gradient_button.dart';

class OnboardingScreen3 extends StatefulWidget {
  const OnboardingScreen3({super.key});

  @override
  State<OnboardingScreen3> createState() => _OnboardingScreen3State();
}

class _OnboardingScreen3State extends State<OnboardingScreen3> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(AppImages.splash5
              ), fit: BoxFit.cover),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height / 7,
                    horizontal: 36),
                child: Image.asset(AppImages.logo),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 3.5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Your',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                        ),
                        4.hspace,
                        Text(
                          ' Personal',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                  color: const Color(0xff10d6cd),
                                  fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    2.vspace,
                     Text(
                      'AI Tutor',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: const Color(0xffE131AE),
                          fontWeight: FontWeight.bold),
                    ),
                    8.vspace,
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width / 6,
                          right: MediaQuery.of(context).size.width / 6),
                      child: Text(
                        '  "Ask questions, get answers. Anytime, anywhere."',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    48.vspace,
                    GradientButtonWidget(
                      height: 40,
                      text: 'Next',
                      width: 130,
                      onTap: () {
                        Get.toNamed(Appnames.login);
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}