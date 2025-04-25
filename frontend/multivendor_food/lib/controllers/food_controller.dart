import 'package:get/get.dart';

class FoodController extends GetxController {
  RxInt currentPage = 0.obs;

  void changePage(int index) {
    currentPage.value = index;
  }
}
