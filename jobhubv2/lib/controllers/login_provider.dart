import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobhubv2_0/constants/app_constants.dart';
import 'package:jobhubv2_0/controllers/zoom_provider.dart';
import 'package:jobhubv2_0/models/request/auth/login_model.dart';
import 'package:jobhubv2_0/models/request/auth/profile_update_model.dart';
import 'package:jobhubv2_0/services/helpers/auth_helper.dart';
import 'package:jobhubv2_0/views/screens/auth/profile_page.dart';
import 'package:jobhubv2_0/views/screens/mainscreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginNotifier extends ChangeNotifier {
  bool obscure = true;

  bool get getobscure => obscure;

   bool? entrypoint;

  bool get getentrypoint => entrypoint?? false;

   bool? loggedIn;

  bool get getloggedIn => loggedIn?? false;

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

  logIn(String model,ZoomNotifier notifier) {
    AuthHelper.login(model).then((value) {
      if (value) {
        loader = false;
        notifier.currentIndex = 0;
        // loggedIn=true;
        Get.to(() => const Mainscreen());
      } else {
        loader = false;
        Get.snackbar(
            "Failed to Log In", "Please check your credentials and try again",
            colorText: Color(kLight.value),
            backgroundColor: Color(kOrange.value),
            icon: const Icon(Icons.add_alert));
      }
    });
  }

  Future<void> getPref() async{ 
     
     final SharedPreferences preferences = await SharedPreferences.getInstance();

     entrypoint = preferences.getBool("entrypoint")?? false;
     loggedIn = preferences.getBool("loggedIn")?? false;
     username = preferences.getString("username")?? "";
     userId = preferences.getString("uid")?? "";
     profile = preferences.getString("profile")?? "";

     notifyListeners();

  }
  
  Future<void> logout() async{ 
     
     final SharedPreferences preferences = await SharedPreferences.getInstance();
      // loggedIn=false;
      await preferences.setBool("loggedIn", false);
      await  preferences.remove("token");
      
      notifyListeners();


  }

  

}
