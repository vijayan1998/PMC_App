import 'package:flutter/material.dart';

class CheckBoxWidget extends StatefulWidget {
  final Color borderColor;
  final bool isvalue;
  final String text;
  final void Function(bool?)? onTap;
  const CheckBoxWidget(
      {super.key,
      required this.text,
      required this.borderColor,
      required this.isvalue,
      this.onTap});

  @override
  State<CheckBoxWidget> createState() => _CheckBoxWidgetState();
}

class _CheckBoxWidgetState extends State<CheckBoxWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: widget.isvalue,
          side: const BorderSide(color: Colors.white, width: 2),
          activeColor: Colors.blue,
          onChanged: widget.onTap,
        ),
        Text(
          widget.text,
          style: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(color: Colors.white, fontSize: 18),
        )
      ],
    );
  }
}

class RadioButtonWidget extends StatelessWidget {
  final String text;
  final String groupValue;
  final String value;
  final Function(String?) onChanged;

  const RadioButtonWidget({
    super.key,
    required this.text,
    required this.groupValue,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio<String>(
          value: value,
          groupValue: groupValue,
          onChanged: onChanged,
        ),
        Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
