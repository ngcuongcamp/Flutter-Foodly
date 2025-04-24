import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:multivendor_food/common/shimmers/foodlist_shimmer.dart';
import 'package:multivendor_food/constants/constants.dart';
import 'package:multivendor_food/controllers/category_controller.dart';
import 'package:multivendor_food/hooks/fetch_all_foods.dart';
import 'package:multivendor_food/hooks/fetch_category_foods.dart';
import 'package:multivendor_food/models/foods_model.dart';
import 'package:multivendor_food/views/home/widgets/food_tile.dart';

class CategoryFoodsList extends HookWidget {
  const CategoryFoodsList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CategoryController>();

    // Dùng useState để lưu category & title
    final categoryId = useState(controller.categoryValue);
    final title = useState(controller.titleValue);

    // Theo dõi thay đổi từ controller
    useEffect(() {
      final categoryListener = ever<String>(controller.category, (val) {
        categoryId.value = val;
      });

      final titleListener = ever<String>(controller.title, (val) {
        title.value = val;
      });

      // Cleanup listeners khi widget unmount
      return () {
        categoryListener();
        titleListener();
      };
    }, []);

    // Chọn hook tương ứng
    final hookResult = title.value == "All"
        ? useFetchAllFoods()
        : useFetchCategoryFoods(categoryId.value);

    final isLoading = hookResult.isLoading;
    final foodsList = hookResult.data;

    return SizedBox(
      width: width,
      height: height,
      child: isLoading
          ? const FoodsListShimmer()
          : Padding(
              padding: EdgeInsets.all(12.h),
              child: ListView(
                children: List.generate(foodsList.length, (i) {
                  FoodsModel food = foodsList[i];
                  return FoodTile(food: food);
                }),
              ),
            ),
    );
  }
}
