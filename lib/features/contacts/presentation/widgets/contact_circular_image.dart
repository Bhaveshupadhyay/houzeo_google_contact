import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_color.dart';

class ContactCircularImage extends StatelessWidget {
  final String name;
  final String? imagePath;
  final Color bgColor;
  final double? fontSize;
  final EdgeInsets? padding;
  final double? width;
  final double? height;

  const ContactCircularImage({
    super.key,
    required this.name,
    this.imagePath,
    this.bgColor = AppColors.orange,
    this.fontSize,
    this.padding,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final double effectiveFontSize = fontSize ?? 24.sp;

    final EdgeInsets effectivePadding = padding ?? EdgeInsets.all(20.w);

    Widget content;
    if (imagePath != null && imagePath!.isNotEmpty) {
      content = Image.file(
        File(imagePath!),
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _buildFallbackText(theme, effectiveFontSize),
      );
    } else {
      content = _buildFallbackText(theme, effectiveFontSize);
    }

    return Container(
      width: width?? 70.w,
      height: height?? 70.w,
      // padding: imagePath != null && imagePath!.isNotEmpty? null : effectivePadding,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: bgColor,
      ),
      child: ClipOval(
        child: content,
      ),
    );
  }

  Widget _buildFallbackText(ThemeData theme, double effectiveFontSize) {
    String displayChar = '';
    if (name.isNotEmpty) {
      displayChar = name.substring(0, 1).toUpperCase();
    }

    return Center(
      child: Text(
        displayChar,
        style: theme.textTheme.titleMedium?.copyWith(
          fontSize: effectiveFontSize,
          color: AppColors.white,
        ),
      ),
    );
  }
}