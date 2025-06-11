import 'package:flutter/material.dart';

import '../theme/app_color.dart';

void showSnackBar(BuildContext context, String content, [Color bgColor= AppColors.green]) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(content),
        backgroundColor: bgColor,
      ),
    );
}