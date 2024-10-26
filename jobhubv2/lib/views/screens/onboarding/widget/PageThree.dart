import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jobhubv2_0/constants/app_constants.dart';
import 'package:jobhubv2_0/views/common/custom_outline_btn.dart';
import 'package:jobhubv2_0/views/common/exports.dart';
import 'package:jobhubv2_0/views/screens/mainscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageThree extends StatelessWidget {
  const PageThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: width,
        height: hieght,
        color: Color(kLightBlue.value),
        child: Column(
          children: [
            
            Image.asset('assets/images/page3.png'),
            const SizedBox(height: 20,),
            Column(
              children: [
                ReusableText(text: "Welcome to JobHub", style: appStyle(30, Color(kLight.value), FontWeight.w500)),

                Padding(padding: EdgeInsets.all(30.0.h),               
                child:  Text("We help find your dream job according to your skill and experience.",
                textAlign: TextAlign.center,
                style: appStyle(14, Color(kLight.value),FontWeight.normal) ,
                )),
                const SizedBox(height: 15,),
                CustomOutlineBtn(
                  onTap: () async {
                    SharedPreferences preferences = await SharedPreferences.getInstance();
                    preferences.setBool('entrypoint', true);
                    
                    Get.to(()=>const Mainscreen());
                  },
                  hieght: hieght*0.05,width: width*0.9,text: "Continue as Guest", color: Color(kLight.value))
                
            
              
              
              ],
            )

          ],
        ),
      ),
    );
  }
}
