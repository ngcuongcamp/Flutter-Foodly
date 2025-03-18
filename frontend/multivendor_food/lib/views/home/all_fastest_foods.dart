import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multivendor_food/common/app_style.dart';
import 'package:multivendor_food/common/background_container.dart';
import 'package:multivendor_food/constants/constants.dart';
import 'package:multivendor_food/constants/uidata.dart';
import 'package:multivendor_food/views/home/widgets/food_tile.dart';

class AllFastestFoods extends StatelessWidget {
  const AllFastestFoods({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondary,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kSecondary,
        centerTitle: true,
        title: Text(
          'Fastest Foods',
          style: appStyle(13, kLightWhite, FontWeight.w600),
        ),
      ),
      body: BackgroundContainer(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(12.h),
          child: ListView(
            // scrollDirection: Axis.horizontal,
            children: List.generate(foods.length, (i) {
              final food = foods[i];
              return FoodTile(
                food: food,
              );
            }),
          ),
        ),
      ),
    );
  }
}
