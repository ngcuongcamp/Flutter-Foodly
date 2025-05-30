import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multivendor_food/common/app_style.dart';
import 'package:multivendor_food/common/reusable_text.dart';
import 'package:multivendor_food/constants/constants.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RestaurantsWidget extends StatelessWidget {
  final String image;
  final String logo;
  final String title;
  final String time;
  final String rating;
  final void Function() onTap;

  const RestaurantsWidget(
      {super.key,
      required this.image,
      required this.logo,
      required this.title,
      required this.time,
      required this.rating,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.only(right: 25.w),
          child: Container(
            width: width * 0.75,
            height: 200.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              color: kLightWhite,
            ),
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Padding(
                  padding: EdgeInsets.all(8.w),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12.r),
                        child: SizedBox(
                          height: 170.h,
                          width: width * 0.8,
                          child: Image.network(
                            image,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 10.w,
                        top: 10.h,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(50.r),
                            child: Image.network(
                              logo,
                              fit: BoxFit.cover,
                              width: 25.w,
                              // height: 20.h,
                            )),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ReusableText(
                          text: title,
                          style: appStyle(
                            12,
                            kDark,
                            FontWeight.w500,
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ReusableText(
                            text: 'Delevery time',
                            style: appStyle(
                              9,
                              kDark,
                              FontWeight.normal,
                            ),
                          ),
                          ReusableText(
                            text: time,
                            style: appStyle(
                              9,
                              kDark,
                              FontWeight.normal,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          RatingBarIndicator(
                            rating: 5,
                            itemCount: 5,
                            itemSize: 15.h,
                            itemBuilder: (BuildContext context, int index) {
                              return const Icon(Icons.star, color: kPrimary);
                            },
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          ReusableText(
                            text: '+ $rating reviews and ratings',
                            style: appStyle(
                              9,
                              kDark,
                              FontWeight.w500,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
