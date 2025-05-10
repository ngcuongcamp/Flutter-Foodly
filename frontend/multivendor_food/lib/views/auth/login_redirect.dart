import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:multivendor_food/common/app_style.dart';
import 'package:multivendor_food/common/custom_button.dart';
import 'package:multivendor_food/common/custom_container.dart';
import 'package:multivendor_food/common/reusable_text.dart';
import 'package:multivendor_food/constants/constants.dart';
import 'package:multivendor_food/views/auth/login_page.dart';
import 'package:multivendor_food/views/auth/register_page.dart';

class LoginRedirect extends StatelessWidget {
  const LoginRedirect({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimary,
      appBar: AppBar(
        backgroundColor: kLightWhite,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: kDark),
          onPressed: () {
            Get.back();
          },
        ),
        flexibleSpace: SafeArea(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Center(
                child: ReusableText(
                  isCenter: true,
                  text: "Please login to access this page",
                  style: appStyle(12, kDark, FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: CustomContainer(
            containerContent: Column(
          children: [
            SizedBox(height: 20.h),
            Container(
              width: width,
              height: height / 2,
              color: Colors.white,
              child: LottieBuilder.asset(
                "assets/anime/delivery.json",
                width: width,
                height: height / 2,
              ),
            ),
            CustomButton(
              text: "L O G I N",
              onTap: () {
                Get.to(() => const LoginPage(),
                    transition: Transition.cupertino,
                    duration: const Duration(milliseconds: 900));
              },
              btnHeight: 35.h,
              btnWidth: width - 20,
            ),
            SizedBox(height: 20.h),
            CustomButton(
                text: "R E G I S T E R",
                onTap: () {
                  Get.to(() => const RegisterPage(),
                      transition: Transition.cupertino,
                      duration: const Duration(milliseconds: 900));
                },
                btnHeight: 35.h,
                btnWidth: width - 20,
                color: kSecondary)
          ],
        )),
      ),
    );
  }
}
