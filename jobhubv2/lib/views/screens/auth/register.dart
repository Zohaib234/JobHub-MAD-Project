import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:jobhubv2_0/constants/app_constants.dart';
import 'package:jobhubv2_0/controllers/login_provider.dart';
import 'package:jobhubv2_0/controllers/signup_provider.dart';
import 'package:jobhubv2_0/controllers/zoom_provider.dart';
import 'package:jobhubv2_0/models/request/auth/signup_model.dart';
import 'package:jobhubv2_0/views/common/BackBtn.dart';
import 'package:jobhubv2_0/views/common/app_bar.dart';
import 'package:jobhubv2_0/views/common/app_style.dart';
import 'package:jobhubv2_0/views/common/custom_btn.dart';
import 'package:jobhubv2_0/views/common/custom_textfield.dart';
import 'package:jobhubv2_0/views/common/height_spacer.dart';
import 'package:jobhubv2_0/views/common/pages_loader.dart';
import 'package:jobhubv2_0/views/common/reusable_text.dart';
import 'package:jobhubv2_0/views/common/styled_container.dart';
import 'package:jobhubv2_0/views/screens/auth/login.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController user = TextEditingController();

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    user.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpNotifier>(builder: (context, signUpNotifier, child) {
      return Scaffold(
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: CustomAppBar(text: "Create Account", child: BackBtn())),
        body:signUpNotifier.getloader? const PageLoader(): buildStyleContainer(
            context,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Form(
                  child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  const HeightSpacer(size: 50),
                  ReusableText(
                      text: "Welcome ",
                      style: appStyle(30, Color(kDark.value), FontWeight.w600)),
                  ReusableText(
                      text: "Fill in the Details to create  your account",
                      style: appStyle(
                          14, Color(kDarkGrey.value), FontWeight.w400)),
                  const HeightSpacer(size: 50),
                  CustomTextField(
                    controller: user,
                    hintText: "Enter your full name",
                    keyboardType: TextInputType.emailAddress,
                    validator: (user) {
                      if (user!.isEmpty) {
                        return "please enter a valid username";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const HeightSpacer(size: 20),
                  CustomTextField(
                    controller: email,
                    hintText: "Enter your email",
                    keyboardType: TextInputType.emailAddress,
                    validator: (email) {
                      if (email!.isEmpty || email.contains("@")) {
                        return "please enter a valid email";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const HeightSpacer(size: 20),
                  CustomTextField(
                      controller: password,
                      hintText: "Password",
                      obscureText: signUpNotifier.getobscure,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          signUpNotifier.setobscure =
                              !signUpNotifier.getobscure;
                        },
                        child: Icon(
                          signUpNotifier.getobscure
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                      validator: (password) {
                        if (password!.isEmpty || password.length < 8) {
                          return "password must be at least 8 characters";
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.text),
                  const HeightSpacer(size: 15),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() => const LoginPage());
                      },
                      child: ReusableText(
                          text: "Already have account , login",
                          style: appStyle(
                              14, Color(kDark.value), FontWeight.w500)),
                    ),
                  ),
                  const HeightSpacer(size: 50),
                  Consumer<ZoomNotifier>(
                      builder: (context, zoomNotifier, child) {
                    return CustomButton(
                      text: "Create Account",
                      onTap: () {
                        signUpNotifier.setloader = true;
                        SignupModel model = SignupModel(
                          username: user.text,
                          email: email.text,
                          password:  password.text
                          
                        );
                        String newmodel = signupModelToJson(model);
                        signUpNotifier.signUp(newmodel);

                      },
                    );
                  })
                ],
              )),
            )),
      );
    });
  }
}
