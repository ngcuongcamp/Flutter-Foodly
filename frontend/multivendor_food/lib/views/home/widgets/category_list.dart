import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:multivendor_food/constants/uidata.dart';
import 'package:multivendor_food/hooks/fetchCategories.dart';
import 'package:multivendor_food/models/categories_model.dart';
import 'package:multivendor_food/views/home/widgets/category_widget.dart';

class CategoryList extends HookWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    final hookResult = useFetchCategories();

    List<CategoriesModel> categoriesList = hookResult.data;
    // final isLoading = hookResult.isLoading;
    // final error = hookResult.error;

    return Container(
      margin: EdgeInsets.only(top: 5.h, bottom: 5.h),
      height: 85.h,
      padding: EdgeInsets.only(left: 12.w, top: 10.h),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: List.generate(categories.length, (i) {
          var category = categories[i];
          return CategoryWidget(category: category);
        }),
      ),
    );
  }
}
