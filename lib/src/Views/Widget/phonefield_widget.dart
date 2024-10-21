import 'package:flutter/material.dart';
import 'package:pmc/src/Views/Widget/textfield_drawpaint.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class PhoneNumberField extends StatelessWidget {
  final double height;
  final double width;
  final double topsize;
  final TextEditingController textEditingController;
  final String hintText;
  final Color hintColor;
  const PhoneNumberField(
      {super.key,
      required this.height,
      required this.width,
      required this.topsize,
      required this.textEditingController,
      required this.hintText,
      required this.hintColor});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: RectanglePainter(Colors.white, topsize),
      child: SizedBox(
        height: height,
        width: width,
        child: Padding(
          padding: const EdgeInsets.only(top: 24.0),
          child: IntlPhoneField(
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Colors.white,
            ),
            controller: textEditingController,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(color: hintColor,),
            ),
            initialCountryCode: 'IN',
            dropdownTextStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white,
            fontSize: 24),
            onChanged: (phone) {},
            validator: (value) {
              if (value == null) {
                return 'Please enter a phone number';
              } else if (!value.isValidNumber()) {
                return 'Please enter a valid phone number';
              } else {
                return null;
              }
            },
          ),
        ),
      ),
    );
  }
}
