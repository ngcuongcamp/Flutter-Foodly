import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:multivendor_food/common/custom_container.dart';
import 'package:multivendor_food/common/custom_text_field.dart';
import 'package:multivendor_food/common/shimmers/foodlist_shimmer.dart';
import 'package:multivendor_food/constants/constants.dart';
import 'package:multivendor_food/controllers/search_controller.dart';
import 'package:multivendor_food/views/search/loading_widget.dart';
import 'package:multivendor_food/views/search/search_result.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final controller = Get.put(SearchFoodController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: kPrimary,
        appBar: AppBar(
            toolbarHeight: 74.h,
            elevation: 0,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            title: Padding(
              padding: EdgeInsets.only(top: 12.h),
              child: CustomTextWidget(
                controller: _searchController,
                keyboardType: TextInputType.text,
                hintText: "Search For Foods",
                // prefixIcon: Icon(Icons.search, color: kGray),
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Nút xoá input
                    if (_searchController.text.isNotEmpty)
                      IconButton(
                        icon: Icon(
                          Ionicons.close_circle,
                          size: 24.h,
                          color: kRed,
                        ),
                        onPressed: () {
                          _searchController.clear();
                          controller.searchResult = null;
                          setState(
                              () {}); // Cập nhật UI để ẩn nút clear nếu input rỗng
                        },
                      ),

                    // Nút tìm kiếm
                    IconButton(
                      icon: Icon(
                        Ionicons.search_circle,
                        size: 30.h,
                        color: kPrimary,
                      ),
                      onPressed: () {
                        if (_searchController.text.trim().isNotEmpty) {
                          controller.searchFoods(_searchController.text.trim());
                          FocusScope.of(context).unfocus(); // Ẩn bàn phím
                        } else {
                          Get.snackbar(
                              "Thông báo", "Vui lòng nhập từ khóa tìm kiếm");
                        }
                      },
                    ),
                  ],
                ),
              ),
            )),
        body: SafeArea(
          child: Obx(
            () => CustomContainer(
              color: Colors.white,
              containerContent: controller.isLoading
                  ? const FoodsListShimmer()
                  : controller.searchResult == null
                      ? const LoadingWidget()
                      : SearchResults(),
            ),
          ),
        ));
  }
}
