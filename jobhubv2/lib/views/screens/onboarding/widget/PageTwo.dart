import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jobhubv2_0/constants/app_constants.dart';
import 'package:jobhubv2_0/views/common/app_style.dart';
import 'package:jobhubv2_0/views/common/reusable_text.dart';

class PageTwo extends StatelessWidget {
  const PageTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: width,
        height: hieght,
        color: Color(kDarkBlue.value),
        child: Column(
          children: [
            const SizedBox(
              height: 70,
            ),
            Padding(
              padding:  EdgeInsets.all(8.0.h),
              child: Image.asset('assets/images/page2.png'),
            ),
            const SizedBox(height: 20,),
            Column(
              children: [
                Text("Stable yourself \n  without your abilities", textAlign: TextAlign.center  , style: appStyle(30, Color(kLight.value), FontWeight.w500)),


                Padding(padding: EdgeInsets.all(30.0.h),               
                child:  Text("We help find your dream job according to your skill and experience. We help find your dream job according to your skill and experience   ",
                textAlign: TextAlign.center,
                style: appStyle(14, Color(kLight.value),FontWeight.normal) ,
                )),
                
            
              
              
              ],
            )

          ],
        ),
      ),);
  }
}