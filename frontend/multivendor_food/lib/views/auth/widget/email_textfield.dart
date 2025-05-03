import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multivendor_food/common/app_style.dart';
import 'package:multivendor_food/constants/constants.dart';

class EmailTextField extends StatelessWidget {
  const EmailTextField({
    super.key,
    this.onEditingComplete,
    this.keyboardType,
    this.initialValue,
    this.controller,
    this.hintText,
    this.prefixIcon,
  });

  final void Function()? onEditingComplete;
  final TextInputType? keyboardType;
  final String? initialValue;
  final TextEditingController? controller;
  final String? hintText;
  final Widget? prefixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: kDark,
      textInputAction: TextInputAction.next,
      onEditingComplete: onEditingComplete,
      keyboardType: keyboardType ?? TextInputType.emailAddress,
      initialValue: initialValue,
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email address';
        } else if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
            .hasMatch(value)) {
          return 'Please enter a valid email address';
        }
        return null;
      },
      style: appStyle(14, kGray, FontWeight.normal),
      decoration: InputDecoration(
          hintText: "Enter your email address",
          // hintStyle: ,
          prefixIcon: const Icon(
            CupertinoIcons.mail,
            color: kGrayLight,
            size: 22,
          ),
          isDense: true,
          contentPadding: EdgeInsets.all(6.h),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: kRed, width: .5),
              borderRadius: BorderRadius.all(Radius.circular(12.r))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: kPrimary, width: .5),
              borderRadius: BorderRadius.all(Radius.circular(12.r))),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: kRed, width: .5),
              borderRadius: BorderRadius.all(Radius.circular(12.r))),
          disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: kGray, width: .5),
              borderRadius: BorderRadius.all(Radius.circular(12.r))),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: kPrimary, width: .5),
              borderRadius: BorderRadius.all(Radius.circular(12.r))),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: kPrimary, width: .5),
            borderRadius: BorderRadius.all(
              Radius.circular(12.r),
            ),
          )),
    );
  }
}
