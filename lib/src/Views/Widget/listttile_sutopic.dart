import 'package:flutter/material.dart';

class ListttileSutopic extends StatelessWidget {
  final String lessonname;
  const ListttileSutopic({super.key, required this.lessonname});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Row(
      children: [
        Text(
          lessonname,
          style: const TextStyle(color: Colors.white),
        ),
        const SizedBox(
          width: 10,
        ),
        Container(
          height: 20.0,
          width: 20.0,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 1),
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(6),
                topRight: Radius.circular(6),
                bottomRight: Radius.circular(6)),
          ),
          child: const Icon(
            Icons.check,
            color: Colors.white,
            size: 10,
          ),
        )
      ],
    ));
  }
}
