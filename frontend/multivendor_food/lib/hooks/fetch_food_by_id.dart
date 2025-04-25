import 'dart:convert';
import 'package:multivendor_food/constants/constants.dart';
import 'package:multivendor_food/models/api_error_model.dart';
import 'package:multivendor_food/models/foods_model.dart';
import 'package:multivendor_food/models/hook_models/hook_result.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_hooks/flutter_hooks.dart';

FetchHook useFetchFoodById(String id) {
  final foodItem = useState<FoodsModel?>(null);
  final isLoading = useState<bool>(false);
  final error = useState<Exception?>(null);
  final apiError = useState<ApiErrorModel?>(null);

  Future<void> fetchData() async {
    isLoading.value = true;
    try {
      Uri url = Uri.parse('$appBaseUrl/food/byId/$id');
      final response = await http.get(url);
      final jsonResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        if (jsonResponse['status'] == true && jsonResponse['data'] is Map) {
          foodItem.value = FoodsModel.fromJson(jsonResponse['data']);
        } else {
          error.value = Exception('Invalid API response');
        }
      } else {
        apiError.value = apiErrorModelFromJson(response.body);
      }
      isLoading.value = false;
    } catch (e) {
      error.value = e is Exception ? e : Exception('Error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  useEffect(() {
    // Future.delayed(const Duration(seconds: 3));
    fetchData();
    return null;
  }, []);

  void refetch() {
    isLoading.value = true;
    fetchData();
  }

  return FetchHook(
    isLoading: isLoading.value,
    data: foodItem.value,
    error: error.value,
    refetch: refetch,
  );
}
