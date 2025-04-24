import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multivendor_food/common/app_style.dart';
import 'package:multivendor_food/common/background_container.dart';
import 'package:multivendor_food/common/shimmers/nearby_shimmer.dart';
import 'package:multivendor_food/constants/constants.dart';
import 'package:multivendor_food/hooks/fetch_all_restaurants.dart';
import 'package:multivendor_food/models/restaurantsModel.dart';
import 'package:multivendor_food/views/home/widgets/restaurant_title.dart';

class AllNearbyRestaurants extends HookWidget {
  const AllNearbyRestaurants({super.key});

  @override
  Widget build(BuildContext context) {
    final hookResult = useFetchAllRestaurants("");

    List<RestaurantsModel> restaurantsList = hookResult.data;
    final isLoading = hookResult.isLoading;
    final error = hookResult.error;

    return Scaffold(
      backgroundColor: kSecondary,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kSecondary,
        centerTitle: true,
        title: Text('Nearby restaurants',
            style: appStyle(13, kLightWhite, FontWeight.w600)),
      ),
      body: BackgroundContainer(
        color: Colors.white,
        child: Padding(
          padding:
              EdgeInsets.only(left: 12.h, right: 12.h, top: 14.h, bottom: 14.h),
          child: isLoading
              ? NearbyShimmer()
              : ListView(
                  // scrollDirection: Axis.horizontal,
                  children: List.generate(restaurantsList.length, (i) {
                    RestaurantsModel restaurant = restaurantsList[i];
                    return RestaurantTile(
                      restaurant: restaurant,
                    );
                  }),
                ),
        ),
      ),
    );
  }
}
