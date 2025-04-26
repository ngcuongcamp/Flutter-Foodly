import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:multivendor_food/common/app_style.dart';
import 'package:multivendor_food/common/custom_button.dart';
import 'package:multivendor_food/common/reusable_text.dart';
import 'package:multivendor_food/constants/constants.dart';
import 'package:multivendor_food/controllers/food_controller.dart';
import 'package:multivendor_food/hooks/fetch_restaurant_by_id.dart';
import 'package:multivendor_food/models/foods_model.dart';
import 'package:multivendor_food/views/restaurant/restaurant_page.dart';

class FoodPage extends StatefulWidget {
  const FoodPage({
    super.key,
    required this.food,
  });
  final FoodsModel food;

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FoodController());

    return Scaffold(
      body: HookBuilder(builder: (context) {
        final hookResult = useFetchRestaurantById(widget.food.restaurant);
        return ListView(
          padding: EdgeInsets.zero,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(30.r),
              ),
              child: Stack(
                children: [
                  SizedBox(
                    height: 300.h,
                    child: PageView.builder(
                        controller: _pageController,
                        onPageChanged: (index) {
                          controller.changePage(index);
                        },
                        itemCount: widget.food.imageUrl.length,
                        itemBuilder: (context, i) {
                          return Container(
                            width: width,
                            height: 300.h,
                            color: kLightWhite,
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: widget.food.imageUrl[i],
                            ),
                          );
                        }),
                  ),
                  Positioned(
                    bottom: 10,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Obx(() => Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(widget.food.imageUrl.length,
                                (index) {
                              return Container(
                                margin: EdgeInsets.all(4.h),
                                width: 15.w,
                                height: 15.h,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: controller.currentPage == index
                                      ? kSecondary
                                      : kGray,
                                ),
                              );
                            }),
                          )),
                    ),
                  ),
                  Positioned(
                    top: 40.h,
                    left: 12.w,
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(
                        Ionicons.chevron_back_circle,
                        color: kPrimary,
                        size: 35,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 12.w,
                    child: CustomButton(
                        onTap: () {
                          Get.to(() => RestaurantPage(
                                restaurant: hookResult.data,
                              ));
                        },
                        btnWidth: 120.w,
                        text: "Explore Restaurant",
                        color: kSecondary),
                  ),
                ],
              ),
            ),

            // title
            Container(
              padding: EdgeInsets.only(left: 14.w, top: 12.h, right: 14.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ReusableText(
                        text: widget.food.title,
                        style: appStyle(18, kDark, FontWeight.w600),
                      ),
                      ReusableText(
                        text: "\$${widget.food.price.toString()}",
                        style: appStyle(16, kPrimary, FontWeight.w600),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    widget.food.description,
                    style: appStyle(11, kGray, FontWeight.w400),
                    maxLines: 8,
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: 15.h),
                  SizedBox(
                    height: 35.h,
                    child: ListView(
                        scrollDirection: Axis.horizontal,
                        children:
                            List.generate(widget.food.foodTags.length, (index) {
                          final tag = widget.food.foodTags[index];
                          return Container(
                            margin: EdgeInsets.only(right: 5.w),
                            decoration: BoxDecoration(
                              color: kPrimary,
                              borderRadius: BorderRadius.all(
                                Radius.circular(15.r),
                              ),
                            ),
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 6.w, vertical: 2.h),
                                child: ReusableText(
                                  text: tag,
                                  style: appStyle(11, kWhite, FontWeight.w400),
                                ),
                              ),
                            ),
                          );
                        })),
                  ),
                  SizedBox(height: 20.h),
                  ReusableText(
                    text: "Additives and Toppings",
                    style: appStyle(16, kDark, FontWeight.w600),
                  ),
                  SizedBox(height: 15.h),
                  Column(
                    children:
                        List.generate(widget.food.additives.length, (index) {
                      final additive = widget.food.additives[index];
                      return CheckboxListTile(
                        contentPadding: EdgeInsets.zero,
                        visualDensity: VisualDensity.compact,
                        dense: true,
                        activeColor: kSecondary,
                        value: true,
                        tristate: false,
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ReusableText(
                              text: additive.title,
                              style: appStyle(11, kDark, FontWeight.w400),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            ReusableText(
                              text: "\$ ${additive.price.toString()}",
                              style: appStyle(11, kPrimary, FontWeight.w600),
                            ),
                          ],
                        ),
                        onChanged: (bool? value) {
                          print(value);
                        },
                      );
                    }),
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ReusableText(
                        text: "Quantity",
                        style: appStyle(16, kDark, FontWeight.w600),
                      ),
                      SizedBox(width: 5.w),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: const Icon(AntDesign.pluscircleo),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: ReusableText(
                                text: "1",
                                style: appStyle(14, kDark, FontWeight.w600)),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: const Icon(AntDesign.minuscircleo),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        );
      }),
    );
  }
}
