import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:multivendor_food/common/app_style.dart';
import 'package:multivendor_food/common/background_container.dart';
import 'package:multivendor_food/common/custom_button.dart';
import 'package:multivendor_food/views/auth/widget/email_textfield.dart';
import 'package:multivendor_food/common/reusable_text.dart';
import 'package:multivendor_food/constants/constants.dart';
import 'package:multivendor_food/views/auth/register_page.dart';
import 'package:multivendor_food/views/auth/widget/password_textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController _emailController = TextEditingController();
  late final TextEditingController _passwordController =
      TextEditingController();

  final FocusNode _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kPrimary,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: kPrimary,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: kOffWhite,
            ),
            onPressed: () {
              Get.back();
            },
          ),
          flexibleSpace: Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                ReusableText(
                  text: "Foodly Family",
                  style: appStyle(
                    20,
                    kOffWhite,
                    FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
        body: BackgroundContainer(
          color: kOffWhite,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.r),
              topRight: Radius.circular(30.r),
            ),
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                SizedBox(height: 30.h),
                Lottie.asset("assets/anime/delivery.json"),
                SizedBox(height: 20.h),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      EmailTextField(
                        controller: _emailController,
                      ),
                      SizedBox(height: 20.h),
                      PasswordTextField(
                        controller: _passwordController,
                      ),
                      SizedBox(height: 15.h),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.to(
                                    () => const RegisterPage(),
                                    transition: Transition.fadeIn,
                                    duration:
                                        const Duration(milliseconds: 1200),
                                  );
                                },
                                child: ReusableText(
                                  text: "Register",
                                  style:
                                      appStyle(12, kPrimary, FontWeight.normal),
                                ),
                              ),
                            ]),
                      ),
                      SizedBox(height: 15.h),
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
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
