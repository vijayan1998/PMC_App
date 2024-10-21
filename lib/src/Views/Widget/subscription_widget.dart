import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmc/src/Views/Routes/route_name.dart';
import 'package:pmc/src/Views/Widget/button_widget.dart';
import 'package:pmc/src/Views/Widget/custom_drawpage.dart';

class SubscriptionWidget extends StatelessWidget {
  final double width;
  final double? height;
  final String text1;
  final String text2;
  final String text3;
  final String text4;
  final String text5;
  final String text6;
  final String text7;

  const SubscriptionWidget({super.key, required this.width, this.height, required this.text1, required this.text2, required this.text3, required this.text4, required this.text5, required this.text7, required this.text6});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: CustomDrawPage(const Color.fromRGBO(139, 175, 76, 1),
      Colors.white, const Color.fromRGBO(139, 175, 76, 1)),
      child:Container(
        padding: const EdgeInsets.only(left: 8,right: 8),
        width:width,
        height:height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(text1,style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),),
                 Text(text2,style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),),
                Text(text3,style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Colors.black,
                ),),
                Text(text4,style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Colors.black,
                ),),
                Text(text5,style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Colors.black,
                ),),
                 Text(text6,style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Colors.black,
                ),),
                Text(text7,style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Colors.black,
                ),),    
              ],
            ),
            CommonButtonWidget(
              text: 'Select', 
              height: MediaQuery.of(context).size.height / 20, 
              width: MediaQuery.of(context).size.width /4, 
              fillColor: Colors.yellow, 
              borderColor: Colors.white, 
              shadowColor: Colors.red.withOpacity(0.75), 
              textColor: Colors.black, 
              onPressed: (){
                Get.toNamed(Appnames.navigator);
              })
          ],
        ),
      ),
    );
  }
}