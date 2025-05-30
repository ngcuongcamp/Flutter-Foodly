import 'dart:convert';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;

import 'package:multivendor_food/constants/constants.dart';
import 'package:multivendor_food/models/api_error_model.dart';
import 'package:multivendor_food/models/hook_models/hook_result.dart';
import 'package:multivendor_food/models/restaurantsModel.dart';

FetchHook useFetchAllRestaurants(String code) {
  // final categoriesItems = useState<List<RestaurantsModel>?>(null);
  final categoriesItems = useState<List<RestaurantsModel>?>([]);
  final isLoading = useState<bool>(false);
  final error = useState<Exception?>(null);
  final apiError = useState<ApiErrorModel?>(null);

  Future<void> fetchData() async {
    isLoading.value = true;
    try {
      Uri url = Uri.parse('$appBaseUrl/api/restaurant/getAll/$code');
      final response = await http.get(url);
      final jsonResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        if (jsonResponse['status'] == true && jsonResponse['data'] is List) {
          categoriesItems.value = List<RestaurantsModel>.from(
            jsonResponse['data'].map((x) => RestaurantsModel.fromJson(x)),
          );
        } else {
          error.value = Exception('Invalid API response');
        }
      } else {
        apiError.value = apiErrorModelFromJson(response.body);
      }
    } catch (e) {
      error.value = e is Exception ? e : Exception('Error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  useEffect(() {
    fetchData();
    return null;
  }, []);

  void refetch() {
    isLoading.value = true;
    fetchData();
  }

  return FetchHook(
    isLoading: isLoading.value,
    data: categoriesItems.value,
    error: error.value,
    refetch: refetch,
  );
}
