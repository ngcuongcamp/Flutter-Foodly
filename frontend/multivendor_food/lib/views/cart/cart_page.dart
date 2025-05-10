import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:multivendor_food/common/custom_container.dart';
import 'package:multivendor_food/constants/constants.dart';
import 'package:multivendor_food/controllers/login_controller.dart';
import 'package:multivendor_food/models/login_response.dart';
import 'package:multivendor_food/views/auth/login_redirect.dart';
import 'package:multivendor_food/views/auth/verification_page.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final controller = Get.put(LoginController());
    LoginResponse? user;

    String? token = box.read('token');

    if (token != null) {
      user = controller.getUserInfo();
    }

    if (token == null) {
      return const LoginRedirect();
    }

    if (user != null && user.verification == false) {
      return const VerificationPage();
    }

    return Scaffold(
      backgroundColor: kPrimary,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(130.h),
          child: Container(
            height: 130,
          )),
      body: SafeArea(
          child: CustomContainer(
        containerContent: Container(),
      )),
    );
  }
}
