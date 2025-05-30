import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:multivendor_food/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'package:multivendor_food/models/api_error_model.dart';
import 'package:multivendor_food/models/login_response.dart';
import 'package:multivendor_food/views/auth/verification_page.dart';
import 'package:multivendor_food/views/entrypoint.dart';

class LoginController extends GetxController {
  final box = GetStorage();

  final RxBool _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  set setLoading(bool newState) {
    _isLoading.value = newState;
  }

  void loginFunction(String data) async {
    setLoading = true;
    Uri url = Uri.parse('$appBaseUrl/login');
    Map<String, String> headers = {'Content-Type': 'application/json'};

    try {
      var response = await http.post(url, headers: headers, body: data);
      if (response.statusCode == 200) {
        LoginResponse data = loginResponseFromJson(response.body);

        String userId = data.id;

        // Lưu dữ liệu trực tiếp dưới dạng Map bằng phương thức toJson()
        box.write(userId, data.toJson());
        box.write("token", data.userToken);
        box.write("userId", userId);
        box.write("verification", data.verification);

        setLoading = false;

        Get.snackbar(
            "You are successfully logged in", "Enjoy your awesome experience",
            backgroundColor: kPrimary,
            icon: const Icon(Ionicons.fast_food_outline),
            snackPosition: SnackPosition.TOP,
            duration: Duration(seconds: 2),
            titleText: Text("You are successfully logged in",
                style: TextStyle(
                    fontSize: 14,
                    color: kLightWhite,
                    fontWeight: FontWeight.bold)),
            messageText: Text(
              "Enjoy your awesome experience",
              style: TextStyle(
                fontSize: 12,
                color: kLightWhite,
              ),
            ));

        if (data.verification == false) {
          Get.offAll(() => const VerificationPage(),
              transition: Transition.fade,
              duration: Duration(milliseconds: 900));
        }

        if (data.verification == true) {
          Get.offAll(() => MainScreen(title: ""),
              transition: Transition.fade,
              duration: const Duration(milliseconds: 900));
        }
      } else {
        var error = apiErrorModelFromJson(response.body);

        Get.snackbar(
          "Failed to login",
          error.message,
          backgroundColor: kRed,
          icon: const Icon(Icons.error_outline),
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 2),
          titleText: Text(
            "Failed to login",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: kLightWhite,
            ),
          ),
          messageText: Text(
            error.message,
            style: TextStyle(fontSize: 12, color: kLightWhite),
          ),
        );
      }
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  void logout() async {
    await box.erase();

    Get.offAll(
      () => MainScreen(title: ""),
      transition: Transition.fade,
      duration: const Duration(milliseconds: 900),
    );
  }

  LoginResponse? getUserInfo() {
    String? userId = box.read('userId');
    Map<String, dynamic>? data;

    if (userId != null) {
      data = box.read(userId);
    }

    if (data != null) {
      return LoginResponse.fromJson(data);
    }

    return null;
  }
}
