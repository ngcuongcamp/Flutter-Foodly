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
import 'package:multivendor_food/models/hook_models/hook_result.dart';
import 'package:multivendor_food/views/home/widgets/food_tile.dart';

class CategoryFoodsList extends HookWidget {
  const CategoryFoodsList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryController());

    late final FetchHook hookResult;
    if (controller.titleValue == "All") {
      hookResult = useFetchAllFoods();
    } else {
      hookResult = useFetchCategoryFoods(controller.categoryValue, "");
    }

    List<FoodsModel> foodsList = hookResult.data;
    final isLoading = hookResult.isLoading;
    final error = hookResult.error;

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
