import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:multivendor_food/common/app_style.dart';
import 'package:multivendor_food/common/custom_button.dart';
import 'package:multivendor_food/common/custom_container.dart';
import 'package:multivendor_food/common/reusable_text.dart';
import 'package:multivendor_food/constants/constants.dart';
import 'package:multivendor_food/controllers/verification_controller.dart';
import 'package:multivendor_food/views/auth/login_redirect.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

import '../../controllers/login_controller.dart';

class VerificationPage extends StatelessWidget {
  const VerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerificationController());
    final logoutController = Get.put(LoginController());

    final box = GetStorage();

    String? token = box.read('token');

    if (token == null) {
      return const LoginRedirect();
    }

    return Scaffold(
      appBar: AppBar(
        title: ReusableText(
            text: "Please Verify Your Account",
            style: appStyle(12, kGray, FontWeight.w600)),
        centerTitle: true,
        backgroundColor: kWhite,
        elevation: 0,
      ),
      body: CustomContainer(
        color: kWhite,
        containerContent: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: SizedBox(
              height: height,
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  Lottie.asset("assets/anime/delivery.json"),
                  SizedBox(
                    height: 10.h,
                  ),
                  ReusableText(
                    text: "Verify Your Account",
                    style: appStyle(20, kPrimary, FontWeight.w600),
                    // isCenter: true,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    "Enter the 6-digit code sent to your email, if you don't see the code, please chekc your spam folder.",
                    textAlign: TextAlign.justify,
                    style: appStyle(11, kGray, FontWeight.w600),
                    // isCenter: true,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  OtpTextField(
                    numberOfFields: 6,
                    borderColor: kSecondary,
                    borderWidth: 2.0,
                    textStyle: appStyle(17, kDark, FontWeight.w600),
                    showFieldAsBox: true,
                    onCodeChanged: (String code) {},
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    onSubmit: (String verificationCode) {
                      controller.setCode = verificationCode;
                    },
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  CustomButton(
                    text: "V E R I F Y   A C C O U N T",
                    onTap: () {
                      controller.verificationFunction();
                    },
                    btnHeight: 35.h,
                    btnWidth: width,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  CustomButton(
                    text: "L O G O U T",
                    onTap: () {
                      logoutController.logout();
                    },
                    btnHeight: 35.h,
                    btnWidth: width,
                    color: kSecondary,
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
