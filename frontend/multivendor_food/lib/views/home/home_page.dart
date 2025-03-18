import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:multivendor_food/common/custom_appbar.dart';
import 'package:multivendor_food/common/custom_container.dart';
import 'package:multivendor_food/common/heading.dart';
import 'package:multivendor_food/constants/constants.dart';
import 'package:multivendor_food/views/home/all_fastest_foods.dart';
import 'package:multivendor_food/views/home/all_nearby_restaurants.dart';
import 'package:multivendor_food/views/home/recommendations_page.dart';
import 'package:multivendor_food/views/home/widgets/category_list.dart';
import 'package:multivendor_food/views/home/widgets/food_list.dart';
import 'package:multivendor_food/views/home/widgets/nearby_restaurants_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimary,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(130.h),
        child: CustomAppBar(),
      ),
      body: SafeArea(
          child: CustomContainer(
        containerContent: Column(
          children: [
            CategoryList(),
            Heading(
                text: "Nearby Restaurants",
                onTap: () {
                  Get.to(() => const AllNearbyRestaurants(),
                      transition: Transition.cupertino,
                      duration: Duration(milliseconds: 900));
                }),
            NearbyRestaurantsList(),
            Heading(
                text: "Try Something New",
                onTap: () {
                  Get.to(() => Recommendations(),
                      transition: Transition.cupertino,
                      duration: Duration(milliseconds: 900));
                }),
            FoodList(),
            Heading(
                text: "Food Closer To You",
                onTap: () {
                  Get.to(() => AllFastestFoods(),
                      transition: Transition.cupertino,
                      duration: Duration(milliseconds: 900));
                }),
            FoodList()
          ],
        ),
      )),
    );
  }
}


// 2:01