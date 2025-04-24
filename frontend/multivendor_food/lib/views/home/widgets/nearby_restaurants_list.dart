import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multivendor_food/common/shimmers/foodlist_shimmer.dart';
import 'package:multivendor_food/hooks/fetch_restaurants.dart';
import 'package:multivendor_food/models/restaurantsModel.dart';
import 'package:multivendor_food/views/home/widgets/restaurant_widget.dart';

class NearbyRestaurantsList extends HookWidget {
  const NearbyRestaurantsList({super.key});

  @override
  Widget build(BuildContext context) {
    final hookResult = useFetchRestaurants("41007428");
    List<RestaurantsModel> restaurantList = hookResult.data;
    final isLoading = hookResult.isLoading;
    final error = hookResult.error;

    return Container(
      height: 280.h,
      padding: EdgeInsets.only(left: 12.w, top: 10.h),
      child: isLoading
          ? FoodsListShimmer()
          : ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(restaurantList.length, (i) {
                RestaurantsModel restaurant = restaurantList[i];
                return RestaurantsWidget(
                  image: restaurant.imageUrl.toString(),
                  logo: restaurant.logoUrl.toString(),
                  title: restaurant.title,
                  time: restaurant.time,
                  rating: restaurant.ratingCount,
                  onTap: () {},
                );
              }),
            ),
    );
  }
}
