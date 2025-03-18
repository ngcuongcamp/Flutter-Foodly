import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:multivendor_food/common/app_style.dart';
import 'package:multivendor_food/common/reusable_text.dart';
import 'package:multivendor_food/constants/constants.dart';

class FoodTile extends StatelessWidget {
  final dynamic food;
  const FoodTile({super.key, this.food});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 8.h),
            height: 90.h,
            width: width,
            decoration: BoxDecoration(
              color: kOffWhite,
              borderRadius: BorderRadius.circular(9.r),
            ),
            child: Container(
              padding: EdgeInsets.all(4.r),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(12.r)),
                    child: Stack(
                      children: [
                        SizedBox(
                          height: 70.h,
                          width: 70.w,
                          child: Image.network(
                            food["imageUrl"],
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Container(
                            padding: EdgeInsets.only(left: 6.w, bottom: 2.h),
                            // color: kGray.withOpacity(0.6),
                            color: kGray.withAlpha(153),
                            height: 16.h,
                            width: width,
                            child: RatingBarIndicator(
                              rating: 5,
                              itemCount: 5,
                              itemBuilder: (context, i) {
                                return const Icon(Icons.star,
                                    color: kSecondary);
                              },
                              itemSize: 12.h,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 15.w,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ReusableText(
                            text: food['title'],
                            style: appStyle(
                              11,
                              kDark,
                              FontWeight.w400,
                            )),
                        ReusableText(
                            text: 'Delivery time: ${food['time']}',
                            style: appStyle(
                              11,
                              kGray,
                              FontWeight.w400,
                            )),
                        SizedBox(
                          width: width * 0.7,
                          height: 20.h,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: food['additives'].length,
                            itemBuilder: (context, i) {
                              final additive = food['additives'][i];
                              return Container(
                                margin: EdgeInsets.only(right: 5.w),
                                decoration: BoxDecoration(
                                    color: kSecondaryLight,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(9.r))),
                                child: Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(4.h),
                                    child: ReusableText(
                                        text: additive['title'],
                                        style: appStyle(
                                            8, kGray, FontWeight.w400)),
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            right: 5.w,
            top: 6.h,
            child: Container(
              width: 60.w,
              height: 20.h,
              decoration: BoxDecoration(
                color: kPrimary,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Center(
                  child: ReusableText(
                text: "\$ ${food['price'].toStringAsFixed(2)}",
                style: appStyle(12, kLightWhite, FontWeight.w600),
              )),
            ),
          ),
          Positioned(
            right: 75.w,
            top: 6.h,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                width: 20.w,
                height: 20.h,
                decoration: BoxDecoration(
                    color: kSecondary,
                    // borderRadius: BorderRadius.circular(10.r),
                    shape: BoxShape.circle),
                child: Center(
                    child: Icon(MaterialCommunityIcons.cart_plus,
                        size: 16.h, color: kLightWhite)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
