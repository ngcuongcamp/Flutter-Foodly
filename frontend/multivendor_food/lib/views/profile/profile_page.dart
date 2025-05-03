import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:multivendor_food/common/custom_button.dart';
import 'package:multivendor_food/common/custom_container.dart';
import 'package:multivendor_food/common/profile_app_bar.dart';
import 'package:multivendor_food/constants/constants.dart';
import 'package:multivendor_food/views/auth/login_redirect.dart';
import 'package:multivendor_food/views/profile/widget/profile_tile_widget.dart';
import 'package:multivendor_food/views/profile/widget/user_info_widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimary,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.h),
        child: ProfileAppBar(),
      ),
      body: SafeArea(
          child: CustomContainer(
        containerContent: Column(
          children: [
            // const UserInfoWidget(),
            SizedBox(height: 10.h),
            Container(
                height: 200.h,
                decoration: const BoxDecoration(color: kLightWhite),
                child: ListView(
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    ProfileTileWidget(
                      onTap: () {
                        Get.to(() => const LoginRedirect());
                      },
                      title: "My Orders",
                      icon: Ionicons.fast_food_outline,
                    ),
                    ProfileTileWidget(
                      onTap: () {},
                      title: "My Favorite Places",
                      icon: Ionicons.heart_outline,
                    ),
                    ProfileTileWidget(
                      onTap: () {},
                      title: "Reviews",
                      icon: Ionicons.chatbubble_outline,
                    ),
                    ProfileTileWidget(
                      onTap: () {},
                      title: "Communication",
                      icon: MaterialCommunityIcons.tag_outline,
                    )
                  ],
                )),
            SizedBox(
              height: 15.h,
            ),
            Container(
              height: 200.h,
              decoration: const BoxDecoration(color: kLightWhite),
              child: ListView(
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  ProfileTileWidget(
                    onTap: () {},
                    title: "Shipping Address",
                    icon: SimpleLineIcons.location_pin,
                  ),
                  ProfileTileWidget(
                    onTap: () {},
                    title: "Sevice Center",
                    icon: AntDesign.customerservice,
                  ),
                  ProfileTileWidget(
                    onTap: () {},
                    title: "Coupons",
                    icon: MaterialIcons.rss_feed,
                  ),
                  ProfileTileWidget(
                    onTap: () {},
                    title: "Settings",
                    icon: AntDesign.setting,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            CustomButton(
              onTap: () {},
              color: kRed,
              text: "Logout",
              border: 0,
            )
          ],
        ),
      )),
    );
  }
}
