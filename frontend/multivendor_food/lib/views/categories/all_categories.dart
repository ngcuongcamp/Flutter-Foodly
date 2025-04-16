import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:multivendor_food/common/app_style.dart';
import 'package:multivendor_food/common/background_container.dart';
import 'package:multivendor_food/common/reusable_text.dart';
import 'package:multivendor_food/common/shimmers/foodlist_shimmer.dart';
import 'package:multivendor_food/constants/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multivendor_food/hooks/fetch_all_categories.dart';
import 'package:multivendor_food/models/categories_model.dart';
import 'package:multivendor_food/views/categories/category_tile.dart';

class AllCategories extends HookWidget {
  const AllCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final hookResult = useAllFetchCategories();

    List<CategoriesModel> categoriesList = hookResult.data;
    final isLoading = hookResult.isLoading;
    final error = hookResult.error;

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
          child: isLoading
              ? FoodsListShimmer()
              : ListView(
                  scrollDirection: Axis.vertical,
                  children: List.generate(categoriesList.length, (i) {
                    CategoriesModel category = categoriesList[i];
                    return CategoryTile(category: category);
                  }),
                ),
        ),
      ),
    );
  }
}
