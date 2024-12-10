import 'package:flutter/material.dart';

class SubscriptionWidget extends StatelessWidget {
  final double width;
  final String text1;
  final String text2;
  final String text3;
  final String text4;
  final String text5;
  final String text6;
  final String text7;
  final Widget buttonwidget;

  const SubscriptionWidget({super.key, required this.width, required this.text1, required this.text2, required this.text3, required this.text4, required this.text5, required this.text7, required this.text6, required this.buttonwidget});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.only(top: 8,left: 8,right: 8,bottom: 8),
      width:width,
      color:const Color(0xff4C07F4).withOpacity(0.25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(text1,style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),),
               Text(text2,style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),),
              Text(text3,style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),),
              Text(text4,style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w400
              ),),
              Text(text5,style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w400
              ),),
               Text(text6,style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w400
              ),),
              Text(text7,style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w400
              ),),    
            ],
          ),
        buttonwidget,
        ],
      ),
    );
  }
}