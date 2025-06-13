import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonTextField extends StatelessWidget {

  final String hintText;
  final String? labelText;
  final Icon? prefixIcon;
  final Icon? suffixIcon;
  final TextEditingController textEditingController;
  final VoidCallback? onIconTap;
  final VoidCallback? onTap;
  final TextInputType keyboardType;
  final Border? border;
  final Color? bgColor;
  final BorderRadius? borderRadius;
  final Function(String)? onTextChanged;
  final EdgeInsets? contentPadding;
  final List<TextInputFormatter>? inputFormatters;
  final bool isOptional;
  final FocusNode? focusNode;
  final InputDecoration? inputDecoration;



  const CommonTextField({super.key, required this.hintText, this.suffixIcon,
    required this.textEditingController, this.onIconTap, required this.keyboardType,
    this.border, this.onTap, this.inputFormatters, this.bgColor, this.prefixIcon, this.onTextChanged, this.borderRadius, this.contentPadding, this.labelText, this.isOptional=false, this.inputDecoration, this.focusNode, });

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        borderRadius: borderRadius??BorderRadius.circular(20.r),
        border: border,
        color: bgColor
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if(prefixIcon!=null)
            Padding(
              padding: EdgeInsets.only(left: 15.w),
              child: prefixIcon,
            ),
          Expanded(
            child: TextFormField(
              focusNode: focusNode,
                onTap: onTap,
                onTapOutside: (event) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                controller: textEditingController,
                keyboardType: keyboardType,
                inputFormatters: inputFormatters,
                decoration: inputDecoration??
                    InputDecoration(
                    hintText: hintText,
                  labelText: labelText
                ),
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontSize: 15.sp,
                ),
              validator: (value) {
                if (!isOptional && value!.isEmpty) {
                  return "$hintText is missing!";
                }
                return null;
              },
              onChanged: onTextChanged
            ),
          ),

          if(suffixIcon!=null)
            InkWell(
              onTap: onIconTap,
              child: suffixIcon,
            ),
          SizedBox(width: 10.w,),
        ],
      ),
    );
  }
}
