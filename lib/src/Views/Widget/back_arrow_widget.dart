import 'package:flutter/material.dart';

class BackArrowWidget extends StatelessWidget {
  final Function()? onTap;
  const BackArrowWidget({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // alignment: Alignment.center,
        width: 16,
         padding: const EdgeInsets.only(left: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white
        ),
        child: const Icon(Icons.arrow_back_ios,color: Colors.black,size: 16,),
      ),
    );
  }
}