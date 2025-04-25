import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;

import 'package:multivendor_food/constants/constants.dart';
import 'package:multivendor_food/models/api_error_model.dart';
import 'package:multivendor_food/models/hook_models/restaurant_hook.dart';
import 'package:multivendor_food/models/restaurantsModel.dart';

FetchRestaurant useFetchRestaurantById(String id) {
  final categoryItem = useState<RestaurantsModel?>(null);
  final isLoading = useState<bool>(false);
  final error = useState<Exception?>(null);
  final apiError = useState<ApiErrorModel?>(null);

  Future<void> fetchData() async {
    isLoading.value = true;
    try {
      Uri url = Uri.parse('$appBaseUrl/restaurant/byId/$id');
      final response = await http.get(url);
      final jsonResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        if (jsonResponse['status'] == true && jsonResponse['data'] != null) {
          // Nếu data là object (không phải list)
          categoryItem.value = RestaurantsModel.fromJson(jsonResponse['data']);
        } else {
          error.value = Exception('Invalid API response');
        }
      } else {
        apiError.value = apiErrorModelFromJson(response.body);
      }
    } catch (e) {
      error.value = e is Exception ? e : Exception('Error: $e');
      debugPrint(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  useEffect(() {
    fetchData();
    return null;
  }, [id]);

  void refetch() {
    isLoading.value = true;
    fetchData();
  }

  return FetchRestaurant(
    isLoading: isLoading.value,
    data: categoryItem.value,
    error: error.value,
    refetch: refetch,
  );
}
