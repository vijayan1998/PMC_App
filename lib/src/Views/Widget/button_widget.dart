

import 'package:flutter/material.dart';
import 'package:pmc/src/Views/Widget/custom_drawpage.dart';

// ignore: must_be_immutable
class CommonButtonWidget extends StatelessWidget {
  final String text;
  final double? height;
  final double width;
  final Color fillColor;
  final Color borderColor;
  final Color shadowColor;
  final Color textColor;
  void Function()? onPressed;
   CommonButtonWidget({super.key, required this.text,  this.height, required this.width, required this.fillColor, required this.borderColor, required this.shadowColor, required this.textColor, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onPressed,
      child: CustomPaint(
            painter: CustomDrawPage(fillColor,borderColor,shadowColor),
            child: Container(
              padding: const EdgeInsets.all(8),
              width: width,
              height: height,
              child: Text(text,style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color:textColor,
                fontWeight: FontWeight.w400
              ),
              textAlign: TextAlign.center,
              ),
            ),
          ),
    );
  }
}