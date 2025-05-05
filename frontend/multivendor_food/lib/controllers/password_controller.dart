import 'package:get/get.dart';

class PasswordController extends GetxController {
  final RxBool _password = false.obs;

  // getter for password value
  bool get password => _password.value;

  // setter for password value

  void toggleVisibilityPassword() {
    _password.value = !_password.value;
  }
}
