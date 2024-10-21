import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:pmc/src/Views/Routes/route_name.dart';
import 'package:pmc/src/Views/Utilies/images.dart';
import 'package:pmc/src/Views/Utilies/sizedbox_widget.dart';
import 'package:pmc/src/Views/Widget/button_widget.dart';
import 'package:pmc/src/Views/Widget/common_widget.dart';
import 'package:pmc/src/Views/Widget/flipcard_widget.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final controller = FlipCardController();

  // Add boolean flags for each animation
  bool isImageAtBottom = true;
  bool isTextAnimated = false;
  bool isButtonAnimated = false;
  bool isAiTextAnimated = false;
  bool isAiGirlAnimated = false;

  @override
  void initState() {
    super.initState();

    // Automatically start animations in sequence after screen is displayed
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startImageAnimation();
    });
  }

  void _startImageAnimation() {
    setState(() {
      isImageAtBottom = !isImageAtBottom;
    });

    // Start next animation after delay
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        isTextAnimated = true;
      });

      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          isButtonAnimated = true;
        });

        Future.delayed(const Duration(seconds: 3), () {
          setState(() {
            isAiTextAnimated = true;
          });

          Future.delayed(const Duration(seconds: 3), () {
            setState(() {
              isAiGirlAnimated = true;
            });
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 36, left: 4, right: 4, bottom: 8),
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(AppImages.background), fit: BoxFit.fill),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 8),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / 14,
                  right: MediaQuery.of(context).size.width / 14),
              child: FlipcardWidget(
                controller: controller,
                front: Image.asset(AppImages.logo),
                back: Image.asset(AppImages.logo),
              ),
            ),
            if (isTextAnimated)
              Positioned(
                top: MediaQuery.of(context).size.height / 7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonContainer(
                        fillColor: const Color(0xff17202a),
                        text:
                            'Discover the future of learning with Pick My Course. Our  AI-Powered platform creates engaging courses tailored to your needs. Unlock your full potential today!',
                        borderColor: Colors.white,
                        width: MediaQuery.of(context).size.width / 1.3,
                        shadowColor: Colors.green.withOpacity(0.55)),
                    36.vspace,
                    if (isButtonAnimated)
                      Animate(
                        effects: const [
                          SlideEffect(
                              begin: Offset(0, 15),
                              end: Offset(0, -0),
                              duration: Duration(seconds: 2))
                        ],
                        child: Row(
                          children: [
                            CommonButtonWidget(
                              text: 'Login',
                              height: MediaQuery.of(context).size.height / 18,
                              width: MediaQuery.of(context).size.width / 2.8,
                              fillColor: Colors.lightGreenAccent,
                              borderColor: Colors.white,
                              textColor: Colors.black,
                              shadowColor: Colors.lightGreenAccent,
                              onPressed: () {
                                Get.toNamed(Appnames.login);
                              },
                            ),
                            16.hspace,
                            CommonButtonWidget(
                              text: 'Signup',
                              height: MediaQuery.of(context).size.height / 18,
                              width: MediaQuery.of(context).size.width / 2.8,
                              fillColor: Colors.yellow,
                              borderColor: Colors.white,
                              textColor: Colors.black,
                              shadowColor: Colors.yellow,
                              onPressed: () {
                                Get.toNamed(Appnames.register);
                              },
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            if (isAiTextAnimated)
              Animate(
                effects: const [
                  SlideEffect(
                      begin: Offset(0, 1),
                      end: Offset(0, -0),
                      duration: Duration(seconds: 2)),
                ],
                child: Positioned(
                  top: MediaQuery.of(context).size.height / 14,
                  right: -5,
                  child: RotatedBox(
                    quarterTurns: -1,
                    child: Text(
                      'AI COURSE GENERATOR',
                      // ignore: deprecated_member_use
                      textScaleFactor: 1.5,
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                    ),
                  ),
                ),
              ),
            if (isAiGirlAnimated)
              Animate(
                effects: const [
                  SlideEffect(
                      begin: Offset(0, 5),
                      end: Offset(0, -0),
                      duration: Duration(seconds: 2)),
                ],
                child: Positioned(
                  top: MediaQuery.of(context).size.height / 2.35,
                  child: Image.asset(
                    AppImages.ai,
                    height: MediaQuery.of(context).size.height / 2.25,
                    fit: BoxFit.cover,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
