import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobhubv2_0/constants/app_constants.dart';
import 'package:jobhubv2_0/models/request/auth/signup_model.dart';
import 'package:jobhubv2_0/services/helpers/auth_helper.dart';
import 'package:jobhubv2_0/views/screens/auth/login.dart';

class SignUpNotifier extends ChangeNotifier {
  bool obscure = true;

  bool get getobscure => obscure;

  set setobscure(bool value) {
    obscure = value;
    notifyListeners();
  }

  bool loader = false;

  bool get getloader => loader;

  set setloader(bool value) {
    loader = value;
    notifyListeners();
  }

  final signupFormKey = GlobalKey<FormState>();
  bool validateandSave() {
    final form = signupFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  signUp(String model) {
    AuthHelper.signup(model).then((value) {
      if (value) {
        loader = false;
        Get.offAll(() => const LoginPage());
      } else {
        loader = false;
        Get.snackbar(
            "Failed to Sign up", "Please check your credentials and try again",
            colorText: Color(kLight.value),
            backgroundColor: Color(kOrange.value),
            icon: const Icon(Icons.add_alert));
      }
    });
  }
}
