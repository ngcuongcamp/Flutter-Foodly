import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:multivendor_food/common/app_style.dart';
import 'package:multivendor_food/common/reusable_text.dart';
import '../constants/constants.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      height: 110.h,
      width: width,
      color: kOffWhite,
      child: Container(
        margin: EdgeInsets.only(top: 20.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CircleAvatar(
                  radius: 22.r,
                  backgroundColor: kSecondary,
                  backgroundImage: const NetworkImage(
                      'https://res.cloudinary.com/dwy653wkg/image/upload/v1745400714/default_avatar_rmq7ob_c_crop_w_600_h_600_neq6kv.png'),
                ),
                Padding(
                  // padding: EdgeInsets.only(bottom: 6.h, left: 8.w),r
                  padding: EdgeInsets.only(bottom: 6.h, left: 8.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ReusableText(
                          text: "Deliver to",
                          style: appStyle(13, kSecondary, FontWeight.w500)),
                      SizedBox(
                        width: width * 0.65,
                        child: Text("Ha Dong, Ha Noi, Vietnam",
                            overflow: TextOverflow.ellipsis,
                            style: appStyle(11, kGrayLight, FontWeight.normal)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Text(
            //   getTimeOfDay(),
            //   style: const TextStyle(fontSize: 35),
            // )
            getIconByTimeOfDay()
          ],
        ),
      ),
    );
  }

  String getTimeOfDay() {
    DateTime now = DateTime.now();
    int hour = now.hour;

    if (hour >= 0 && hour < 12) {
      return ' ☀️ ';
    } else if (hour >= 12 && hour < 16) {
      return ' ⛅ ';
    } else {
      return ' 🌙 ';
    }
  }

  Widget getIconByTimeOfDay() {
    DateTime now = DateTime.now();
    int hour = now.hour;

    if (hour >= 0 && hour < 12) {
      return Lottie.asset('assets/lotties/sun.json', width: 40.w, height: 40.h);
    } else if (hour >= 12 && hour < 16) {
      return Lottie.asset('assets/lotties/sun-2.json',
          width: 40.w, height: 40.h);
    } else {
      return Lottie.asset('assets/lotties/moon.json',
          width: 40.w, height: 40.h);
    }
  }
}
