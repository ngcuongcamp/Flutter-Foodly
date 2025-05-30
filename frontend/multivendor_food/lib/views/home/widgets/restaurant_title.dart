import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multivendor_food/common/app_style.dart';
import 'package:multivendor_food/common/reusable_text.dart';
import 'package:multivendor_food/constants/constants.dart';
import 'package:multivendor_food/models/restaurantsModel.dart';

class RestaurantTile extends StatelessWidget {
  const RestaurantTile({super.key, required this.restaurant});
  // final dynamic restaurant;
  final RestaurantsModel restaurant;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 8.h),
            height: 115.h,
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
                          height: 90.h,
                          width: 100.w,
                          child: Image.network(
                            restaurant.imageUrl,
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
                            text: restaurant.title,
                            style: appStyle(
                              11,
                              kDark,
                              FontWeight.w400,
                            )),
                        ReusableText(
                            text: 'Delivery time: ${restaurant.time}',
                            style: appStyle(
                              11,
                              kGray,
                              FontWeight.w400,
                            )),
                        SizedBox(
                          width: width * 0.7,
                          child: Text(
                            restaurant.coords.address,
                            style: appStyle(9, kGray, FontWeight.w400),
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
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
              height: 25.h,
              decoration: BoxDecoration(
                color: restaurant.isAvailable == true ||
                        restaurant.isAvailable == null
                    ? kPrimary
                    : kSecondary,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Center(
                child: ReusableText(
                    text: restaurant.isAvailable == true ||
                            restaurant.isAvailable == null
                        ? 'Open'
                        : 'Closed',
                    style: appStyle(
                      12,
                      kLightWhite,
                      FontWeight.w600,
                    )),
              ),
            ),
          )
        ],
      ),
    );
  }
}
