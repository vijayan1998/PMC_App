import 'package:flutter/material.dart';

class GradientButtonWidget extends StatelessWidget {
  final String text;
  final double width;
  final double? height;
  final Function()? onTap;
  const GradientButtonWidget({super.key, required this.text, required this.width, this.onTap,  this.height});

  @override
  Widget build(BuildContext context) {
    return  Material(
      child: InkWell(
        onTap: onTap,
        child: Container(
                              height: height,
                              width: width,
                              padding: const EdgeInsets.all(7),
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                stops: [
                                  0.2,
                                  1,
                                  2,
                                  2,
                                ],
                                colors: [
                                  Color(0xffA61CD2),
                                  Color(0xff4C07F4),
                                  Color(0xff200098),
                                  Color(0xff3D03FA),
                                
                                ],
                              )),
                              child: Text(
                                text,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                              ),
                            ),
      ),
    );
  }
}