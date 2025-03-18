import 'package:flutter/material.dart';
import 'package:multivendor_food/common/app_style.dart';
import 'package:multivendor_food/common/background_container.dart';
import 'package:multivendor_food/common/reusable_text.dart';
import 'package:multivendor_food/constants/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multivendor_food/constants/uidata.dart';
import 'package:multivendor_food/views/categories/category_tile.dart';

class AllCategories extends StatelessWidget {
  const AllCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: kOffWhite,
          centerTitle: true,
          title: ReusableText(
            text: 'All Categories',
            style: appStyle(
              12,
              kGray,
              FontWeight.w600,
            ),
          )),
      body: BackgroundContainer(
        color: Colors.white,
        child: Container(
          padding: EdgeInsets.only(left: 12.w, top: 10.h),
          height: height,
          child: ListView(
            scrollDirection: Axis.vertical,
            children: List.generate(categories.length, (item) {
              var category = categories[item];
              return CategoryTile(category: category);
            }),
          ),
        ),
      ),
    );
  }
}
