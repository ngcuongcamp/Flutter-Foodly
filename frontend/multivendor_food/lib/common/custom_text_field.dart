import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multivendor_food/common/app_style.dart';
import 'package:multivendor_food/constants/constants.dart';

class CustomTextWidget extends StatelessWidget {
  const CustomTextWidget({
    super.key,
    this.keyboardType,
    this.controller,
    this.onEditingComplete,
    this.obscureText,
    this.suffixIcon,
    this.validator,
    this.prefixIcon,
    this.hintText,
    this.maxLines,
    this.fontSize,
  });

  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final void Function()? onEditingComplete;
  final bool? obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final String? hintText;
  final int? maxLines;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(2.h),
        padding: EdgeInsets.only(left: 2.h),
        decoration: BoxDecoration(
            border: Border.all(color: kGray, width: 0.4),
            borderRadius: BorderRadius.circular(9.r)),
        child: TextFormField(
          maxLines: maxLines ?? 1,
          controller: controller,
          keyboardType: keyboardType,
          onEditingComplete: onEditingComplete,
          obscureText: obscureText ?? false,
          cursorHeight: 20.h,
          validator: validator,
          style: appStyle(11, kDark, FontWeight.normal),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: appStyle((fontSize ?? 11), kGray, FontWeight.normal),
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
          ),
        ));
  }
}
