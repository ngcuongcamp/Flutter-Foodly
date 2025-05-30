import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:multivendor_food/controllers/tab_index_controller.dart';
import 'package:multivendor_food/views/cart/cart_page.dart';
import 'package:multivendor_food/views/home/home_page.dart';
import 'package:multivendor_food/views/profile/profile_page.dart';
import 'package:multivendor_food/views/search/search_page.dart';
import '../constants/constants.dart';

class MainScreen extends StatelessWidget {
  final String title;
  MainScreen({super.key, required this.title});

  final List<Widget> pageList = [
    HomePage(),
    SearchPage(),
    CartPage(),
    ProfilePage()
    // LoginPage()
  ];

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TabIndexController());
    return Obx(() => Scaffold(
          body: Stack(
            children: [
              pageList[controller.tabIndex],
              Align(
                alignment: Alignment.bottomCenter,
                child: Theme(
                  data: Theme.of(context).copyWith(canvasColor: kPrimary),
                  child: BottomNavigationBar(
                    showSelectedLabels: false,
                    showUnselectedLabels: false,
                    unselectedIconTheme:
                        const IconThemeData(color: Colors.black38),
                    selectedIconTheme: const IconThemeData(color: kSecondary),
                    onTap: (value) {
                      controller.setTabIndex(value);
                    },
                    currentIndex: controller.tabIndex,
                    items: [
                      BottomNavigationBarItem(
                          icon: controller.tabIndex == 0
                              ? Icon(AntDesign.appstore1, size: 20)
                              : Icon(AntDesign.appstore_o, size: 20),
                          label: 'Home'),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.search, size: 20), label: 'Search'),
                      BottomNavigationBarItem(
                          icon: Badge(
                              child: Icon(FontAwesome.opencart, size: 20)),
                          label: 'Cart'),
                      BottomNavigationBarItem(
                          icon: controller.tabIndex == 3
                              ? Icon(FontAwesome.user_circle, size: 20)
                              : Icon(FontAwesome.user_circle_o, size: 20),
                          label: 'Profile'),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
