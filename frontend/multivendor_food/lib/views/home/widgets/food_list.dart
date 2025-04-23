import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multivendor_food/common/shimmers/foodlist_shimmer.dart';
import 'package:multivendor_food/hooks/fetch_foods.dart';
import 'package:multivendor_food/models/foods_model.dart';
import 'package:multivendor_food/views/home/widgets/food_widget.dart';

class FoodList extends HookWidget {
  const FoodList({super.key});

  @override
  Widget build(BuildContext context) {
    final hookResult = useFetchFoods("41007428");
    List<FoodsModel> foodsList = hookResult.data;
    final isLoading = hookResult.isLoading;
    final error = hookResult.error;

    return Container(
      height: 220.h,
      padding: EdgeInsets.only(left: 12.w, top: 10.h),
      child: isLoading
          ? FoodsListShimmer()
          : ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(foodsList.length, (i) {
                FoodsModel food = foodsList[i];

                return FoodWidget(
                  image: food.imageUrl[0].toString(),
                  title: food.title.toString(),
                  time: food.time.toString(),
                  price: food.price.toStringAsFixed(2),
                  onTap: () {},
                );
              }),
            ),
    );
  }
}
