import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multivendor_food/constants/uidata.dart';
import 'package:multivendor_food/views/home/widgets/food_widget.dart';

class FoodList extends StatelessWidget {
  const FoodList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 192.h,
      padding: EdgeInsets.only(left: 12.w, top: 10.h),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: List.generate(foods.length, (i) {
          final food = foods[i];

          return FoodWidget(
            image: food['imageUrl'][0].toString(),
            title: food['title'].toString(),
            time: food['time'].toString(),
            price: food['price'].toStringAsFixed(2),
            onTap: () {},
          );
        }),
      ),
    );
  }
}
