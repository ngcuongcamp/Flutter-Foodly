import 'package:multivendor_food/constants/constants.dart';
import 'package:multivendor_food/models/api_error_model.dart';
import 'package:multivendor_food/models/hook_models/hook_result.dart';
import 'package:multivendor_food/models/categories_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_hooks/flutter_hooks.dart';

FetchHook useFetchCategories() {
  final categoriesItems = useState<List<CategoriesModel>?>(null);
  final isLoading = useState<bool>(false);
  final error = useState<Exception?>(null);
  final apiError = useState<ApiErrorModel?>(null);

  Future<void> fetchData() async {
    isLoading.value = true;

    Uri url = Uri.parse('$appBaseUrl/api/category/random');
    final response = await http.get(url);
    try {
      if (response.statusCode == 200) {
        categoriesItems.value = categoriesModelFromJson(response.body);
      } else {
        apiError.value = apiErrorModelFromJson(response.body);
      }
    } catch (e) {
      error.value = e as Exception;
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
