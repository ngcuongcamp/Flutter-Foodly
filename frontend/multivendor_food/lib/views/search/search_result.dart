import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:multivendor_food/constants/constants.dart';
import 'package:multivendor_food/controllers/search_controller.dart';
import 'package:multivendor_food/models/foods_model.dart';
import 'package:multivendor_food/views/home/widgets/food_tile.dart';

class SearchResults extends StatelessWidget {
  const SearchResults({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SearchFoodController());

    return Container(
        padding: EdgeInsets.fromLTRB(12.w, 10.h, 12.h, 0),
        height: height,
        child: ListView.builder(
          itemCount: controller.searchResult!.length,
          itemBuilder: (context, i) {
            FoodsModel food = controller.searchResult![i];
            return FoodTile(food: food);
          },
        ));
  }
}
