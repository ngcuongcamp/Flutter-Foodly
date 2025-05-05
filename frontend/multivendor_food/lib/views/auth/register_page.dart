import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:multivendor_food/common/app_style.dart';
import 'package:multivendor_food/common/background_container.dart';
import 'package:multivendor_food/common/custom_button.dart';
import 'package:multivendor_food/controllers/registration_controller.dart';
import 'package:multivendor_food/models/registration_model.dart';
import 'package:multivendor_food/views/auth/widget/email_textfield.dart';
import 'package:multivendor_food/common/reusable_text.dart';
import 'package:multivendor_food/constants/constants.dart';
import 'package:multivendor_food/views/auth/login_page.dart';
import 'package:multivendor_food/views/auth/widget/password_textfield.dart';
import 'package:multivendor_food/views/auth/widget/username_textfield.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late final TextEditingController _emailController = TextEditingController();
  late final TextEditingController _passwordController =
      TextEditingController();

  late final TextEditingController _usernameController =
      TextEditingController();

  final FocusNode _passwordFocusNode = FocusNode();

  final controller = RegistrationController();

  @override
  void dispose() {
    _usernameController.dispose();
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
                      UsernameTextfield(
                        controller: _usernameController,
                      ),
                      SizedBox(height: 20.h),
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
                                    () => const LoginPage(),
                                    transition: Transition.fadeIn,
                                    duration:
                                        const Duration(milliseconds: 1200),
                                  );
                                },
                                child: ReusableText(
                                  text: "Login",
                                  style:
                                      appStyle(12, kPrimary, FontWeight.normal),
                                ),
                              ),
                            ]),
                      ),
                      SizedBox(height: 15.h),
                      CustomButton(
                        text: "R E G I S T E R",
                        onTap: () {
                          if (_emailController.text.isNotEmpty &&
                              _passwordController.text.length >= 8 &&
                              _usernameController.text.isNotEmpty &&
                              _usernameController.text.length >= 5) {
                            RegistrationModel model = RegistrationModel(
                                username: _usernameController.text,
                                email: _emailController.text,
                                password: _passwordController.text);

                            String data = registrationModelToJson(model);
                            print(data);

                            // register function
                            controller.registerFunction(data);
                          }
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
