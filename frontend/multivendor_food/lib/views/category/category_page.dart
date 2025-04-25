import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multivendor_food/common/app_style.dart';
import 'package:multivendor_food/common/background_container.dart';
import 'package:multivendor_food/common/reusable_text.dart';
import 'package:multivendor_food/common/shimmers/foodlist_shimmer.dart';
import 'package:multivendor_food/constants/constants.dart';
import 'package:multivendor_food/controllers/category_controller.dart';
import 'package:multivendor_food/hooks/fetch_category_foods.dart';
import 'package:multivendor_food/models/foods_model.dart';
import 'package:multivendor_food/views/home/widgets/food_tile.dart';

class CategoryPage extends HookWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryController());
    final hookResult = useFetchCategoryFoods(controller.categoryValue);

    List<FoodsModel> foods = hookResult.data;
    final isLoading = hookResult.isLoading;
    // final error = hookResult.error;

    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: kOffWhite,
          title: ReusableText(
            text: "${controller.titleValue} Category",
            style: appStyle(
              12,
              kGray,
              FontWeight.w600,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              controller.updateCategory = "";
              controller.updateTitle = "";
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios, color: kDark),
            color: kGray,
          )),
      body: BackgroundContainer(
        color: Colors.white,
        child: Container(
          padding: EdgeInsets.only(left: 12.w, top: 10.h),
          height: height,
          child: isLoading
              ? FoodsListShimmer()
              : ListView(
                  scrollDirection: Axis.vertical,
                  children: List.generate(foods.length, (i) {
                    FoodsModel food = foods[i];
                    return FoodTile(food: food);
                  }),
                ),
        ),
      ),
    );
  }
}
