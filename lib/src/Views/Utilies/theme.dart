

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pmc/src/Views/Utilies/colors.dart';
import 'package:pmc/src/Views/Utilies/font.dart';

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
          displayMedium: GoogleFonts.alegreya(
            color: AppColors.appColors.shade900,
            fontSize: 30,
            fontWeight: FontWeight.w500
          ),
          headlineSmall: TextStyle(
            color: AppColors.appColors.shade900,
            fontFamily: AppFont.alegreyaSans,
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
          titleLarge: GoogleFonts.alegreya(
            color: AppColors.appColors.shade900,
            fontSize: 30,
            fontWeight: FontWeight.w500,
          ),  
          titleMedium: GoogleFonts.alegreya(
            color: AppColors.appColors.shade100,
            fontSize:25,
            fontWeight:FontWeight.w500,
            ),
            titleSmall: GoogleFonts.alegreya(
            color: AppColors.appColors.shade300,
            fontSize:22,
            fontWeight:FontWeight.w500,
            ),
            bodyLarge: GoogleFonts.alegreyaSans(
              color: AppColors.appColors.shade700,
            fontSize:22,
            fontWeight:FontWeight.w400,
            ),
             bodyMedium: GoogleFonts.alegreyaSans(
              color: AppColors.appColors.shade300,
            fontSize:18,
            fontWeight:FontWeight.w400,
            ),
             bodySmall: GoogleFonts.alegreyaSans(
              color: AppColors.appColors.shade400,
            fontSize:16,
            fontWeight:FontWeight.w400,
            ),
            labelLarge: GoogleFonts.alegreyaSans(
              color:AppColors.appColors.shade200,
              fontSize:20,
              fontWeight: FontWeight.w400,
            ),
          ),

      colorScheme: ColorScheme.light(surface: AppColors.appColors.shade50),
    );
}