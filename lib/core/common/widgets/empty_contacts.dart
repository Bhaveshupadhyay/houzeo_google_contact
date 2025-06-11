import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../theme/app_color.dart';

class EmptyContacts extends StatelessWidget {
  final String lottiePath;
  final String title;
  final String body;
  final VoidCallback? onTap;
  const EmptyContacts({super.key, required this.lottiePath, required this.title, required this.body, this.onTap,});

  @override
  Widget build(BuildContext context) {
    final theme= Theme.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Lottie.asset(
            lottiePath,
            width: 250,
            height: 250,
            fit: BoxFit.contain,
            repeat: true,
          ),
        ),
        SizedBox(height: 16.h),
        Text(
          title,
          style: theme.textTheme.headlineSmall,
        ),
        SizedBox(height: 8.h),
        Text(
          body,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodySmall,
        ),
        SizedBox(height: 20.h),
        if(onTap!=null)
          ElevatedButton.icon(
            onPressed: onTap,
            icon: Icon(Icons.add,color: AppColors.white,),
            label: Text('Add Contact'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
          )
      ],
    );
  }
}
