import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:multivendor_food/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'package:multivendor_food/models/api_error_model.dart';
import 'package:multivendor_food/models/success_model.dart';

class RegistrationController extends GetxController {
  final box = GetStorage();

  final RxBool _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  set setLoading(bool newState) {
    _isLoading.value = newState;
  }

  void registerFunction(String data) async {
    setLoading = true;
    Uri url = Uri.parse('$appBaseUrl/register');
    Map<String, String> headers = {'Content-Type': 'application/json'};

    try {
      var response = await http.post(url, headers: headers, body: data);
      if (response.statusCode == 201) {
        var data = successModelFromJson(response.body);
        setLoading = false;

        Get.snackbar("You are successfully registered", data.message,
            colorText: kLightWhite,
            backgroundColor: kPrimary,
            icon: const Icon(Ionicons.fast_food_outline));
      } else {
        var error = apiErrorModelFromJson(response.body);

        Get.snackbar(
          "Failed to login",
          error.message,
          colorText: kLightWhite,
          backgroundColor: kRed,
          icon: const Icon(Icons.error_outline),
        );
      }
    } catch (err) {
      debugPrint(err.toString());
    }
  }
}
