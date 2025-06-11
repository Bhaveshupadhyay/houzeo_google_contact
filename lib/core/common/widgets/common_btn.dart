import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonBtn extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final EdgeInsets? padding;
  final Color? fillColor;
  final Gradient? gradient;
  final Color? textColor;
  const CommonBtn({super.key, required this.text, required this.onTap, this.padding, this.fillColor, this.gradient, this.textColor});

  @override
  Widget build(BuildContext context) {
    final theme= Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding?? EdgeInsets.symmetric(vertical: 8.h,horizontal: 20.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.r),
          color: fillColor,
          gradient: gradient
        ),
        child: Text(text,
          style: theme.textTheme.titleMedium?.copyWith(
            color: textColor
          ),
        ),
      ),
    );
  }
}
