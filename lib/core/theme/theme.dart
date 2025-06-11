import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_color.dart';

class AppTheme{

  static _border([Color color = AppColors.borderColor]) => OutlineInputBorder(
    borderSide: BorderSide(
      color: color,
      width: 1,
    ),
    borderRadius: BorderRadius.circular(10.r),
  );

  static final ThemeData light=ThemeData.light().copyWith(
    textTheme: TextTheme(
      titleSmall: GoogleFonts.poppins(
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.black
      ),
      titleMedium: GoogleFonts.poppins(
          fontSize: 20.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.black
      ),
      titleLarge: GoogleFonts.poppins(
          fontSize: 45.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.black
      ),
      headlineSmall: GoogleFonts.poppins(
          fontSize: 22.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.black
      ),
      bodySmall: GoogleFonts.poppins(
          fontSize: 15.sp,
          color: AppColors.black
      ),
      bodyMedium: GoogleFonts.poppins(
          fontSize: 20.sp,
          color: AppColors.black
      ),
      bodyLarge: GoogleFonts.poppins(
          fontSize: 30.sp,
          color: AppColors.black
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      unselectedItemColor: AppColors.black,
      selectedItemColor: AppColors.primaryColor,
      showUnselectedLabels: false,
      showSelectedLabels: false,
    ),
    iconTheme: IconThemeData(
        color: AppColors.black
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.symmetric(vertical:20.h,horizontal:20.w),
      border: _border(),
      enabledBorder: _border(AppColors.black.withValues(alpha: 0.5)),
      focusedBorder: _border(AppColors.black),
      errorBorder: _border(AppColors.errorColor),
      hintStyle: GoogleFonts.poppins(
          fontSize: 15.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.greyText
      ),
      labelStyle: GoogleFonts.poppins(
          fontSize: 15.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.greyText
      ),
    ),
  );

  static final ThemeData dark= ThemeData.dark().copyWith(
      scaffoldBackgroundColor: AppColors.black,
      textTheme: TextTheme(
        titleSmall: GoogleFonts.poppins(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.white
        ),
        titleMedium: GoogleFonts.poppins(
            fontSize: 20.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.white
        ),
        titleLarge: GoogleFonts.poppins(
            fontSize: 45.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.white
        ),
        headlineSmall: GoogleFonts.poppins(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.white
        ),
        headlineMedium: GoogleFonts.poppins(
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.white
        ),
        bodySmall: GoogleFonts.poppins(
            fontSize: 15.sp,
            color: AppColors.white
        ),
        bodyMedium: GoogleFonts.poppins(
            fontSize: 20.sp,
            color: AppColors.white
        ),
        bodyLarge: GoogleFonts.poppins(
            fontSize: 30.sp,
            color: AppColors.white
        ),

      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          unselectedItemColor: AppColors.white,
          selectedItemColor: AppColors.primaryColor,
          showUnselectedLabels: false,
          showSelectedLabels: false,
      ),
      iconTheme: IconThemeData(
          color: AppColors.white
      ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.symmetric(vertical:20.h,horizontal:20.w),
      border: _border(),
      enabledBorder: _border(),
      focusedBorder: _border(AppColors.black),
      errorBorder: _border(AppColors.errorColor),
    ),
  );
}