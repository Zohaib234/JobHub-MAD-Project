import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jobhubv2_0/constants/app_constants.dart';
import 'package:jobhubv2_0/views/common/app_style.dart';
import 'package:jobhubv2_0/views/common/custom_outline_btn.dart';
import 'package:jobhubv2_0/views/common/height_spacer.dart';
import 'package:jobhubv2_0/views/common/reusable_text.dart';
import 'package:jobhubv2_0/views/common/styled_container.dart';
import 'package:jobhubv2_0/views/screens/auth/login.dart';

class GuestUser extends StatelessWidget {
  const GuestUser({super.key});

  @override
  Widget build(BuildContext context) {
    return buildStyleContainer(
        context,
        Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(99.w)),
              child: Image(
                  fit: BoxFit.cover,
                  height: 70.w,
                  width: 70.w,
                  image: const NetworkImage(
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSCevVbi_1eUp1UaHjKO0AYUSEViJvIvjkTWwSdjwBoc8YZUR3cOiJHa8OX-brtOQ5IBuY&usqp=CAU")),
            ),
            const HeightSpacer(size: 20),
            ReusableText(
                text: "to access content please login",
                style: appStyle(12, Color(kDarkGrey.value), FontWeight.normal)),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 20.w,vertical: 20..w),
              child: CustomOutlineBtn(
                  width: width,
                  hieght: 40.h,
                  onTap: (){
                    Get.to(()=> const LoginPage());
                  },
                  text: "Proceed to Login ",
                  color: Color(kOrange.value)),
            )
          ],
        ));
  }
}
