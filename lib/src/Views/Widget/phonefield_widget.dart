import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class PhoneNumberField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final Color hintColor;
  const PhoneNumberField(
      {super.key,
      required this.textEditingController,
      required this.hintText,
      required this.hintColor});

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
        color: Colors.grey.shade800,
      ),
    
      dropdownDecoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(8),
          bottomRight: Radius.circular(8)
        ),
        gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            stops: [
                              0.2,
                              1,
                              2,
                              2,
                            ],
                            colors: [
                              Color(0xffA61CD2),
                              Color(0xff4C07F4),
                              Color(0xff200098),
                              Color(0xff3D03FA),
                            
                            ],
                          ) 
      ),
      textAlign: TextAlign.center,
      controller: textEditingController,
      dropdownIcon: const Icon(Icons.arrow_drop_down,color: Colors.white,),
      dropdownIconPosition: IconPosition.trailing,
      decoration: InputDecoration(
        contentPadding:const EdgeInsets.only(top: 12,),
        // border:const OutlineInputBorder(
        //   gapPadding: 0.0,
        //   borderRadius: BorderRadius.all(Radius.circular(8))
        // ),
        hintText: hintText,
        filled: true,
        fillColor: Colors.white,
        hintStyle: Theme.of(context).textTheme.labelLarge!.copyWith(color: hintColor,),
         errorStyle: const TextStyle(
              color: Colors.yellow,
              fontWeight: FontWeight.bold,
            ),
        counterStyle:const TextStyle(
              color: Colors.white, 
              fontSize: 12,
            ),
    
      ),
      initialCountryCode: 'IN',
      
      onChanged: (phone) {
        
      },
      validator: (value) {
        if (value == null) {
          return 'Please enter a phone number';
        } else if (!value.isValidNumber()) {
          return 'Please enter a valid phone number';
        } else {
          return null;
        }
      },
    );
  }
}
