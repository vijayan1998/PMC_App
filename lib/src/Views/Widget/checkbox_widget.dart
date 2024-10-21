import 'package:flutter/material.dart';
import 'package:pmc/src/Views/Utilies/sizedbox_widget.dart';
import 'package:pmc/src/Views/Widget/custom_drawpage.dart';

class CheckBoxWidget extends StatefulWidget {
  final double? height;
  final double width;
  final Color fillColor;
  final Color borderColor;
  final Color shadowColor;
  final bool isvalue;
  final String text;
  final void Function(bool?)? onTap;
  const CheckBoxWidget(
      {super.key,
      this.height,
      required this.text,
      required this.width,
      required this.fillColor,
      required this.borderColor,
      required this.shadowColor,
      required this.isvalue,
      this.onTap});

  @override
  State<CheckBoxWidget> createState() => _CheckBoxWidgetState();
}

class _CheckBoxWidgetState extends State<CheckBoxWidget> {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: CustomDrawPage(
          widget.fillColor, widget.borderColor, widget.shadowColor),
      child: Container(
        padding: const EdgeInsets.all(16),
        width: widget.width,
        height: widget.height,
        child: Row(
          children: [
            Transform.scale(
              scale: 1.5,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.025,
                width: MediaQuery.of(context).size.width * 0.05,
                decoration: const BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: Colors.red,
                    blurRadius: 2,
                  ),
                ]),
                child: Checkbox(
                  value: widget.isvalue,
                  fillColor: WidgetStateProperty.resolveWith((states) {
                    if (!states.contains(WidgetState.selected)) {
                      return Colors.lightGreen;
                    }
                    return null;
                  }),
                  side: const BorderSide(color: Colors.white, width: 2),
                  activeColor: Colors.red,
                  onChanged: widget.onTap,
                ),
              ),
            ),
            24.hspace,
             Text(
              widget.text,
              style:Theme.of(context).textTheme.titleSmall!.copyWith(color: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
