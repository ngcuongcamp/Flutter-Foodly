import 'package:get/get.dart';
import 'package:multivendor_food/models/additive_obs.dart';
import 'package:multivendor_food/models/foods_model.dart';

class FoodController extends GetxController {
  RxInt currentPage = 0.obs;

  bool initialCheckValue = false;
  var additivesList = <AdditiveObs>[].obs;

  void changePage(int index) {
    currentPage.value = index;
  }

  RxInt count = 1.obs;

  void increament() {
    count.value++;
  }

  void decreament() {
    if (count.value > 1) {
      count.value--;
    }
  }

  get currentCount => count.value;

  void loadAdditives(List<Additive> additives) {
    additivesList.clear();

    for (var additiveInfo in additives) {
      var additive = AdditiveObs(
        id: additiveInfo.id,
        title: additiveInfo.title,
        price: additiveInfo.price.toString(),
        checked: initialCheckValue,
      );
      if (additives.length == additivesList.length) {
      } else {
        additivesList.add(additive);
      }
    }
  }

  RxDouble _totalPrice = 0.0.obs;
  double get additivePrice => _totalPrice.value;

  set setTotalPrice(double newPrice) {
    _totalPrice.value = newPrice;
  }

  double getTotalPrice() {
    double totalPrice = 0.0;

    for (var additive in additivesList) {
      if (additive.isChecked.value) {
        totalPrice += double.tryParse(additive.price) ?? 0.0;
      }
    }

    setTotalPrice = totalPrice;
    print("Total Price: $totalPrice");
    return totalPrice;
  }
}
