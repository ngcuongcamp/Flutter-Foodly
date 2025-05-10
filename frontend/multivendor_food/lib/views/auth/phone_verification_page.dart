import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multivendor_food/common/app_style.dart';
import 'package:multivendor_food/controllers/phone_verification_controller.dart';
import 'package:phone_otp_verification/phone_verification.dart';
import 'package:multivendor_food/constants/constants.dart';

class PhoneVerificationPage extends StatelessWidget {
  const PhoneVerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PhoneVerificationController());

    return PhoneVerification(
      isFirstPage: true,
      enableLogo: false,
      themeColor: Colors.blueAccent,
      backgroundColor: kLightWhite,
      initialPageText: "Verify Phone Number",
      initialPageTextStyle: appStyle(20, kPrimary, FontWeight.bold),
      textColor: kDark,
      onSend: (String value) {
        print('Phone number: $value');
        controller.setPhoneNumber = value;
        
      },
      onVerification: (String value) {
        print('OTP: $value');
      },
    );
  }
}
