import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:multivendor_food/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'package:multivendor_food/models/api_error_model.dart';
import 'package:multivendor_food/models/login_response.dart';

class PhoneVerificationController extends GetxController {
  final box = GetStorage();

  final RxBool _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  set setLoading(bool newState) {
    _isLoading.value = newState;
  }

  String _phone = "";
  String get phone => _phone;
  set setPhoneNumber(String value) {
    _phone = value;
    print('set phone number:  $_phone');
  }

  void verifyPhoneFunction() async {
    setLoading = true;
    String accessToken = box.read("token");
    Uri url = Uri.parse('$appBaseUrl/api/users/verify_phone/$phone');

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };

    try {
      var response = await http.get(url, headers: headers);
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
            "You are successfully verified", "Enjoy your awesome experience",
            backgroundColor: kPrimary,
            icon: const Icon(Ionicons.fast_food_outline),
            snackPosition: SnackPosition.TOP,
            duration: Duration(seconds: 2),
            titleText: Text("You are successfully verified",
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

        Get.back();
      } else {
        var error = apiErrorModelFromJson(response.body);

        Get.snackbar(
          "Failed to verify account",
          error.message,
          backgroundColor: kRed,
          icon: const Icon(Icons.error_outline),
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 2),
          titleText: Text(
            "Failed to verify account",
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
}
