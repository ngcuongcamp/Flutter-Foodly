import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:multivendor_food/common/app_style.dart';
import 'package:multivendor_food/common/reusable_text.dart';
import 'package:multivendor_food/constants/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileAppBar extends StatelessWidget {
  const ProfileAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: kOffWhite,
      elevation: 0,
      leading: GestureDetector(
        onTap: () {
          // logout function
        },
        child: Icon(
          AntDesign.logout,
          size: 18.h,
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () {
            // settings function
          },
          child: Padding(
            padding: EdgeInsets.only(right: 12.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/icons/usa.svg",
                  width: 15.w,
                  height: 25.h,
                ),
                SizedBox(
                  width: 5.w,
                ),
                Container(
                  width: 0.w,
                  height: 15.h,
                  color: kGrayLight,
                ),
                SizedBox(
                  width: 5.w,
                ),
                ReusableText(
                    text: "USA", style: appStyle(16, kDark, FontWeight.normal)),
                SizedBox(
                  width: 5.w,
                ),
                GestureDetector(
                  onTap: () {
                    // redirection to the settings page
                  },
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 1.h),
                    child: Icon(
                      SimpleLineIcons.settings,
                      size: 16.h,
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
