import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jobhubv2_0/constants/app_constants.dart';
import 'package:jobhubv2_0/views/common/app_style.dart';

class CustomField extends StatelessWidget {
  const CustomField({
    super.key,
    this.ontap,
    required this.controller,
  });

  final void Function()? ontap;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 45.h,
      padding: EdgeInsets.only(bottom: 5.w),
      color: Color(kLightGrey.value),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Icon(
                    Icons.chevron_left_sharp,
                    size: 30.h,
                    color: Color(kOrange.value),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 20.h),
                width: width * 0.7,
                child: TextFormField(
                  decoration: InputDecoration(
                      hintText: "Search and Apply for Jobs",
                      hintStyle:
                          appStyle(14, Color(kDarkGrey.value), FontWeight.w500),
                      errorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.zero,
                          borderSide:
                              BorderSide(color: Colors.red, width: 0.5)),
                      focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.zero,
                          borderSide:
                              BorderSide(color: Colors.transparent, width: 0)),
                      focusedErrorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.zero,
                          borderSide:
                              BorderSide(color: Colors.red, width: 0.5)),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.zero,
                          borderSide: BorderSide(
                              color: Color(kDarkGrey.value), width: 0.5)),
                      enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.zero,
                          borderSide: BorderSide(
                              color: Colors.transparent, width: 0.5)),
                      border: InputBorder.none),
                  controller: controller,
                  cursorHeight: 25,
                  style: appStyle(14, Color(kDark.value), FontWeight.w500),
                ),
              )
            ],
          ),
          GestureDetector(
            onTap: ontap,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Icon(
                Icons.search_outlined,
                size: 30.h,
                color: Color(kOrange.value),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
