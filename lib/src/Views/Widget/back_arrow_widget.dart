import 'package:flutter/material.dart';

class BackArrowWidget extends StatelessWidget {
  final Function()? onTap;
  const BackArrowWidget({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 36,
        width: 36,
        padding: const EdgeInsets.only(left: 8,right: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            width: 4,
            color: Colors.white,
          )
        ),
        child: const Icon(Icons.arrow_back_ios,color: Colors.white,size: 16,),
      ),
    );
  }
}