import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multivendor_food/constants/uidata.dart';
import 'package:multivendor_food/views/home/widgets/restaurant_widget.dart';

class NearbyRestaurantsList extends StatelessWidget {
  const NearbyRestaurantsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220.h,
      padding: EdgeInsets.only(left: 12.w, top: 10.h),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: List.generate(restaurants.length, (i) {
          final restaurant = restaurants[i];
          return RestaurantsWidget(
            image: restaurant['imageUrl'].toString(),
            logo: restaurant['logoUrl'].toString(),
            title: restaurant['title'],
            time: restaurant['time'],
            rating: restaurant['ratingCount'],
            onTap: () {},
          );
        }),
      ),
    );
  }
}
