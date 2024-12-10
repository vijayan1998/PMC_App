import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CommonButton extends StatelessWidget {
  final String text;
  final double? height;
  void Function()? onPressed;
   CommonButton({super.key,required this.onPressed, required this.text, this.height});

  @override
  Widget build(BuildContext context) {
    return  InkWell(onTap: onPressed,
                                 child: Container(
                                  height: height ,
                                  padding: const EdgeInsets.all(12),
                                  width:MediaQuery.of(context).size.width/2,
                                  decoration: const BoxDecoration(
                                    gradient: LinearGradient( 
                                                   transform: GradientRotation(1),
                                               colors: [
                                                 Color(0xFF3D03FA),
                                                 Color(0xFFA71CD2),
                                               ],),
                                  ),
                                  child: Center(child: Text(text,style: const TextStyle(fontSize: 20,color: Colors.white),)),
                                 ));
  }
}



// ignore: must_be_immutable
class CommonButtonWhite extends StatelessWidget {
  final String text;
  final double? width;
  void Function()? onPressed;
   CommonButtonWhite({super.key,required this.onPressed, required this.text, this.width});

  @override
  Widget build(BuildContext context) {
    return  InkWell(onTap: onPressed,
                                 child: Container(
                                  //height: height ,
                                     width: width,
                                  padding: const EdgeInsets.all(7),
                                // width:MediaQuery.of(context).size.width/2,
                                  decoration: const BoxDecoration(
                                  color: Colors.white
                                  ),
                                  child: Center(child: Text(text,style:Theme.of(context).textTheme.labelMedium!.copyWith(
                                    color: Colors.black
                                  ),)),
                                 ));
  }
}