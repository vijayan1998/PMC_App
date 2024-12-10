

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pmc/src/Views/Utilies/colors.dart';

class AppTheme {
  static var lightTheme = ThemeData(
    appBarTheme: AppBarTheme(
       backgroundColor: AppColors.appColors.shade50),
        scaffoldBackgroundColor:AppColors.appColors.shade50,
      brightness: Brightness.light,
      canvasColor:const Color(0xFF61B15A),
      shadowColor: const Color.fromRGBO(55, 73, 95, 1),
      splashColor: const Color(0xFF82b5ae),
      hintColor: const Color(0xFF4B9145),
      dividerColor: const Color(0xFFDEEBC6),
      focusColor:const Color(0xFFCDE6CB),
      textTheme: TextTheme(
          displayMedium: GoogleFonts.poppins(
            color: AppColors.appColors.shade900,
            fontSize: 26,
            fontWeight: FontWeight.w500
          ),
          headlineLarge: GoogleFonts.poppins(
            color: AppColors.appColors.shade900,
            // fontWeight: FontWeight.w400,
            fontSize: 24,
          ),
          headlineSmall: GoogleFonts.poppins(
            color: AppColors.appColors.shade900,
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
          titleLarge: GoogleFonts.poppins(
            color: AppColors.appColors.shade900,
            fontSize: 28,
          ),  
          titleMedium:GoogleFonts.poppins(
            color: AppColors.appColors.shade100,
            fontSize:24,
            ),
            titleSmall: GoogleFonts.poppins(
            color: AppColors.appColors.shade100,
            fontSize:18,
            fontWeight:FontWeight.w500,
            ),
            bodyLarge: GoogleFonts.poppins(
            color: const Color.fromARGB(255, 255, 255, 255),
            fontSize:18,
            fontWeight:FontWeight.w400,
            ),
             bodyMedium: GoogleFonts.poppins(
              color: Colors.white,
            fontSize:16,
            fontWeight: FontWeight.w400,
            ),
             bodySmall: GoogleFonts.poppins(
              // color: Colors.white,
            fontSize:14,
            fontWeight:FontWeight.w400,
            ),
            labelLarge: GoogleFonts.poppins(
              color:AppColors.appColors.shade200,
              fontSize:16,
              fontWeight: FontWeight.w400,
            ),
            labelMedium: GoogleFonts.poppins(
              // color:AppColors.appColors.shade200,
              fontSize:18,
              fontWeight: FontWeight.w400,
            ),
            labelSmall: GoogleFonts.poppins(
              // color:AppColors.appColors.shade200,
              fontSize:12,
              fontWeight: FontWeight.w400,
            ),
          ),

      colorScheme: ColorScheme.light(surface: AppColors.appColors.shade50),
    );
}