import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multivendor_food/constants/constants.dart';
import 'package:multivendor_food/models/api_error_model.dart';
import 'package:multivendor_food/models/foods_model.dart';
import 'package:http/http.dart' as http;

class SearchFoodController extends GetxController {
  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  set setLoading(bool value) {
    _isLoading.value = value;
  }

  // final RxBool _isTrigger = false.obs;
  // bool get isTrigger => _isTrigger.value;

  // set setTrigger(bool value) {
  //   _isTrigger.value = value;
  // }

  List<FoodsModel>? searchResult;

  void searchFoods(String key) async {
    setLoading = true;
    Uri url = Uri.parse('$appBaseUrl/food/search/$key');
    try {
      var response = await http.get(url);
      final jsonResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        if (jsonResponse['status'] == true && jsonResponse['data'] is List) {
          // searchResult = List<FoodsModel>.from(
          //   jsonResponse['data'].map((x) => FoodsModel.fromJson(x)),
          // );
          searchResult = (jsonResponse['data'] as List)
              .map((x) => FoodsModel.fromJson(x))
              .toList();

          setLoading = false;
        } else {
          setLoading = false;
          var error = apiErrorModelFromJson(response.body);
        }
      }
    } catch (error) {
      setLoading = false;
      debugPrint(error.toString());
    }
  }
}
