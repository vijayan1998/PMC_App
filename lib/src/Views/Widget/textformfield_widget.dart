import 'package:flutter/material.dart';
import 'package:pmc/src/Views/Widget/textfield_drawpaint.dart';

class TextFormWidget extends StatelessWidget {
  final String hintText;
  final double height;
  final double width; 
  final double topsize;
  final Color color;
  final Color fillColor;
  final TextEditingController textEditingController;
  const TextFormWidget({super.key, required this.hintText, required this.height, required this.width, required this.topsize, required this.textEditingController, required this.color, required this.fillColor});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: RectanglePainter(fillColor,topsize),
      child: SizedBox(
        height: height,
        width: width,
        child: Center(
          child: TextFormField(
            controller: textEditingController,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),
            decoration:   InputDecoration(
              contentPadding: const EdgeInsets.all(16),
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: color,
              )
            ),
          ),
        ),
      ),
    );
  }
}


