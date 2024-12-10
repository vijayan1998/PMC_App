import 'package:flutter/material.dart';

class TextFormWidget extends StatelessWidget {
  final String hintText;
  final Color color;
  final Color fillColor;
  final TextEditingController textEditingController;
  final AutovalidateMode? autovalidateMode;
   final String? Function(String?)? validator;
  const TextFormWidget({super.key, required this.hintText, required this.textEditingController, required this.color, required this.fillColor, this.validator, this.autovalidateMode});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: Colors.grey.shade800,
        ),
        autovalidateMode: autovalidateMode,
      decoration:InputDecoration(
         filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.all(8),
        border: InputBorder.none,
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.labelLarge!.copyWith(
          color: color,
        ),
        errorStyle: Theme.of(context).textTheme.labelLarge!.copyWith(
          color: Colors.yellow
        )
      ),
      validator: validator,
    );
  }
}


