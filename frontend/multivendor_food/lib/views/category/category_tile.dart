import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:multivendor_food/common/app_style.dart';
import 'package:multivendor_food/common/reusable_text.dart';
import 'package:multivendor_food/constants/constants.dart';
import 'package:multivendor_food/controllers/category_controller.dart';
import 'package:multivendor_food/models/categories_model.dart';
import 'package:multivendor_food/views/category/category_page.dart';

class CategoryTile extends StatelessWidget {
  const CategoryTile({
    super.key,
    required this.category,
  });

  final CategoriesModel category;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryController());

    return ListTile(
      onTap: () {
        controller.updateCategory = category.id;
        controller.updateTitle = category.title;
        Get.to(
          () => const CategoryPage(),
          transition: Transition.fadeIn,
          duration: const Duration(microseconds: 900),
        );
      },
      leading: CircleAvatar(
        radius: 18.r,
        backgroundColor: kGrayLight,
        child: Image.network(
          category.imageUrl,
          fit: BoxFit.contain,
        ),
      ),
      title: ReusableText(
        text: category.title,
        style: appStyle(
          12,
          kGray,
          FontWeight.normal,
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios_rounded,
        color: kGray,
        size: 15.r,
      ),
    );
  }
}
