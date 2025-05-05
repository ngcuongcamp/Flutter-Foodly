import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:multivendor_food/common/app_style.dart';
import 'package:multivendor_food/constants/constants.dart';
import 'package:multivendor_food/controllers/password_controller.dart';

class PasswordTextField extends StatelessWidget {
  const PasswordTextField({
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
    final passwordController = Get.put(PasswordController());

    return Obx(() => TextFormField(
          cursorColor: kDark,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.visiblePassword,
          controller: controller,
          obscureText: !passwordController.password,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your password';
            } else if (!RegExp(
                    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$')
                .hasMatch(value)) {
              return 'Please enter a valid password';
            }
            return null;
          },
          style: appStyle(14, kGray, FontWeight.normal),
          decoration: InputDecoration(
              hintText: "Password",
              // hintStyle: ,
              prefixIcon: const Icon(
                CupertinoIcons.lock_circle,
                color: kGrayLight,
                size: 22,
              ),
              suffixIcon: GestureDetector(
                onTap: () {
                  passwordController.toggleVisibilityPassword();
                },
                child: Icon(
                  passwordController.password
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: kGrayLight,
                  size: 22,
                ),
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
        ));
  }
}
