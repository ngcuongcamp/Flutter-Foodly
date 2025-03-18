import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:multivendor_food/common/app_style.dart';
import 'package:multivendor_food/common/reusable_text.dart';
import 'package:multivendor_food/constants/constants.dart';
import 'package:multivendor_food/controllers/category_controller.dart';
import 'package:multivendor_food/views/categories/all_categories.dart';

class CategoryWidget extends StatelessWidget {
  final controller = Get.put(CategoryController());
  final Map<String, dynamic> category;

  CategoryWidget({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (controller.categoryValue == category['_id']) {
          // controller.updateCategory = '';
          // controller.updateTitle = '';
        } else if (category['value'] == "more") {
          Get.to(() => const AllCategories(),
              transition: Transition.fadeIn,
              duration: const Duration(microseconds: 900));
        } else {
          controller.updateCategory = category['_id'];
          controller.updateTitle = category['title'];
        }
      },
      child: Obx(
        () => Container(
          margin: EdgeInsets.only(right: 5.w),
          padding: EdgeInsets.only(top: 4.h),
          width: width * 0.19,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(
                color: controller.categoryValue == category['_id']
                    ? kSecondary
                    : kWhite,
                width: .5.w),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 35.h,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                      5.r), // Đảm bảo ảnh cũng có bán kính tương tự
                  child: Container(
                    decoration: BoxDecoration(
                      // border: Border.all(
                      //     color: kSecondary,
                      //     width: .5.w), // Thêm viền cho ảnh
                      borderRadius:
                          BorderRadius.circular(8.r), // Thêm bán kính cho viền
                    ),
                    child: Image.network(
                      category['imageUrl'],
                      fit: BoxFit
                          .cover, // Đảm bảo ảnh bao phủ toàn bộ không gian
                    ),
                  ),
                ),
              ),
              ReusableText(
                text: category['title'],
                style: appStyle(12, kDark, FontWeight.normal),
              )
            ],
          ),
        ),
      ),
    );
  }
}
