import 'package:flutter/material.dart';

class TextfieldWidget extends StatelessWidget {
  final String text;
  const TextfieldWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return    SizedBox(
      height: 50,
      child: TextField(
        style:const TextStyle(color: Colors.black) ,
                    decoration:  InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                     
                                        hintText: text,
                                        hintStyle: const TextStyle(
                                            color: Color.fromARGB(255, 18, 109, 247),
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            borderSide: const BorderSide(
                                                color:
                                                    Colors.white,
                                              )),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            borderSide: const BorderSide(
                                                color:
                                                  Colors.white,
                                              )),
                                      ),
                  ),
    );
  }
}