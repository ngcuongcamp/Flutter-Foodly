import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:multivendor_food/common/app_style.dart';
import 'package:multivendor_food/common/reusable_text.dart';
import 'package:multivendor_food/constants/constants.dart';
import 'package:multivendor_food/models/restaurantsModel.dart';
import 'package:multivendor_food/views/restaurant/directions_page.dart';
import 'package:multivendor_food/views/restaurant/widget/restaurant_bottom_bar.dart';
import 'package:multivendor_food/views/restaurant/widget/restaurant_explore_widget.dart';
import 'package:multivendor_food/views/restaurant/widget/restaurant_menu_widget.dart';

class RestaurantPage extends StatefulWidget {
  const RestaurantPage({super.key, required this.restaurant});

  final RestaurantsModel? restaurant;

  @override
  State<RestaurantPage> createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage>
    with TickerProviderStateMixin {
  late TabController _tabController = TabController(length: 2, vsync: this);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: kLightWhite,
        body: ListView(
          padding: EdgeInsets.zero,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 300.h,
                  width: width,
                  child: CachedNetworkImage(
                    imageUrl: widget.restaurant!.imageUrl,
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: RestaurantBottomBar(widget: widget),
                ),
                Positioned(
                  top: 40.h,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: const Icon(
                            Ionicons.chevron_back_circle,
                            size: 28,
                            color: kLightWhite,
                          ),
                        ),
                        ReusableTextBackground(
                            text: widget.restaurant!.title,
                            style: appStyle(13, kLightWhite, FontWeight.w600)),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => DirectionsPage());
                          },
                          child: const Icon(
                            Ionicons.location,
                            size: 28,
                            color: kLightWhite,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Column(
                children: [
                  RowText(
                    first: "Distance To Restaurant",
                    second: "2.7 km",
                  ),
                  SizedBox(height: 3.h),
                  RowText(
                    first: "Estimated Price",
                    second: "\$2.7",
                  ),
                  SizedBox(height: 3.h),
                  RowText(
                    first: "Estimated Time",
                    second: "30 min",
                  ),
                  SizedBox(height: 3.h),
                  Divider(
                    thickness: 0.7,
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Container(
                height: 30.h,
                width: width,
                decoration: BoxDecoration(
                  color: kOffWhite, // Màu nền của cả TabBar
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: TabBar(
                  controller: _tabController,
                  indicator: BoxDecoration(
                    color: kPrimary,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelColor: kLightWhite,
                  labelStyle: appStyle(12, kLightWhite, FontWeight.normal),
                  unselectedLabelColor: kGrayLight,
                  labelPadding: EdgeInsets.zero,
                  tabs: [
                    Tab(
                      child: Center(child: Text("Menu")),
                    ),
                    Tab(
                      child: Center(child: Text("Explore")),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: SizedBox(
                  height: height,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      RestaurantMenuWidget(restaurantId: widget.restaurant!.id),
                      RestaurantExploreWidget(code: widget.restaurant!.code)
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

class RowText extends StatelessWidget {
  const RowText({
    super.key,
    required this.first,
    required this.second,
  });

  final String first;
  final String second;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ReusableText(text: first, style: appStyle(11, kGray, FontWeight.w500)),
        ReusableText(text: second, style: appStyle(11, kGray, FontWeight.w500)),
      ],
    );
  }
}
