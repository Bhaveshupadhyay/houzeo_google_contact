import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:houzeo/core/theme/app_color.dart';

class ContactOptionsWidget extends StatelessWidget {

  final IconData icon;
  final String text;
  final VoidCallback? onTap;

  const ContactOptionsWidget({super.key, required this.icon, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme= Theme.of(context);

    return InkWell(
      onTap: onTap,
      child: Column(
        spacing: 10.h,
        children: [
          Container(
            padding: EdgeInsets.all(15.w),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.blue,
            ),
            child: Icon(icon,
              color: AppColors.black,
              size: 25.sp,
            ),
          ),
          Text(text,
            style: theme.textTheme.bodySmall,
          )
        ],
      ),
    );
  }
}
