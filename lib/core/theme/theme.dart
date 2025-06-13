import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_color.dart';

class AppTheme{

  static _border([Color color = AppColors.borderColor]) => OutlineInputBorder(
    borderSide: BorderSide(
      color: color,
      width: 1,
    ),
    borderRadius: BorderRadius.circular(10.r),
  );

  ThemeData get light{
    return ThemeData.light().copyWith(
          textTheme: TextTheme(
            titleSmall: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.black
            ),
            titleMedium: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.black
            ),
            titleLarge: TextStyle(
                fontSize: 45.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.black
            ),
            headlineSmall: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.black
            ),
            bodySmall: TextStyle(
                fontSize: 15.sp,
                color: AppColors.black
            ),
            bodyMedium: TextStyle(
                fontSize: 20.sp,
                color: AppColors.black
            ),
            bodyLarge: TextStyle(
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
            hintStyle: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.greyText
            ),
            labelStyle: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.greyText
            ),
          ),
          appBarTheme: AppBarTheme(
            color: AppColors.white
          ),
          scaffoldBackgroundColor: AppColors.white,

        );
  }

  ThemeData get dark{
    return ThemeData.dark().copyWith(
      scaffoldBackgroundColor: AppColors.black,
      textTheme: TextTheme(
        titleSmall: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.white
        ),
        titleMedium: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.white
        ),
        titleLarge: TextStyle(
            fontSize: 45.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.white
        ),
        headlineSmall: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.white
        ),
        headlineMedium: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.white
        ),
        bodySmall: TextStyle(
            fontSize: 15.sp,
            color: AppColors.white
        ),
        bodyMedium: TextStyle(
            fontSize: 20.sp,
            color: AppColors.white
        ),
        bodyLarge: TextStyle(
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
        enabledBorder: _border(AppColors.white.withValues(alpha: 0.5)),
        focusedBorder: _border(AppColors.white),
        errorBorder: _border(AppColors.errorColor),
        hintStyle: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.white
        ),
        labelStyle: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.white
        ),
      ),
    );
  }




}