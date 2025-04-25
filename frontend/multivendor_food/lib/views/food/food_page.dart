import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:multivendor_food/common/custom_button.dart';
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
                          Get.to(() =>
                              RestaurantPage(restaurant: hookResult.data));
                        },
                        btnWidth: 120.w,
                        text: "Explore Restaurant",
                        color: kSecondary),
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
