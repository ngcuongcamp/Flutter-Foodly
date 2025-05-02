import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:multivendor_food/common/shimmers/foodlist_shimmer.dart';
import 'package:multivendor_food/constants/constants.dart';
import 'package:multivendor_food/hooks/fetch_foods.dart';
import 'package:multivendor_food/models/foods_model.dart';
import 'package:multivendor_food/views/home/widgets/food_tile.dart';

class RestaurantExploreWidget extends HookWidget {
  const RestaurantExploreWidget({super.key, required this.code});

  final String code;

  @override
  Widget build(BuildContext context) {
    final hookResults = useFetchFoods(code);
    final foods = hookResults.data;
    final isLoading = hookResults.isLoading;

    return Scaffold(
        backgroundColor: kLightWhite,
        body: isLoading
            ? FoodsListShimmer()
            : SizedBox(
                height: height * 0.7,
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: List.generate(foods.length, (index) {
                    final FoodsModel food = foods[index];
                    return FoodTile(food: food);
                  }),
                ),
              ));
  }
}
