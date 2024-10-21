import 'package:flutter/material.dart';

class OnBoardText extends StatelessWidget {
  final String text;
  final Color color;
  const OnBoardText({super.key, required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.titleSmall!.copyWith(
        color: Colors.white,
      ),
    );
  }
}