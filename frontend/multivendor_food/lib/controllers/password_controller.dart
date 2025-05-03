import 'package:get/get.dart';

class PasswordController extends GetxController {
  RxBool _password = false.obs;

  // getter for password value
  bool get password => _password.value;

  // setter for password value
  set setPassword(bool newState) {
    _password.value = newState;
  }

  void toggleVisibilityPassword() {
    _password.value = !_password.value;
  }
}
