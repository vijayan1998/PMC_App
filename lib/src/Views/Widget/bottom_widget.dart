import 'package:flutter/material.dart';
import 'package:pmc/src/Views/Utilies/images.dart';

class BottomWidget extends StatelessWidget {
  const BottomWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppImages.copyright,height: 16,),
            Text(' PickMyCourse Developed with ',style: Theme.of(context).textTheme.labelSmall!.copyWith(
                color: Colors.white
               ),
               textAlign: TextAlign.center,
               ),
            Image.asset(AppImages.heart,height: 16,),
             Text('  by SeenIT Pty Ltd',style: Theme.of(context).textTheme.labelSmall!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w400
               ),
               textAlign: TextAlign.center,
               ),

          ],
        );
  }
}