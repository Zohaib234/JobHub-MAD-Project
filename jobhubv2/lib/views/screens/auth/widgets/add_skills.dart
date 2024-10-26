import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:jobhubv2_0/constants/app_constants.dart';
import 'package:jobhubv2_0/views/common/custom_textfield.dart';

class AddSkillsWidget extends StatelessWidget {
  const AddSkillsWidget({super.key, required this.skill, this.onTap});

  final TextEditingController skill;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 62.w,
        padding: EdgeInsets.all(2.w),
        
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomTextField(
              controller: skill,
              hintText: "Add new Skill",
              keyboardType: TextInputType.text,
              suffixIcon: GestureDetector(
                onTap: onTap,
                child:  Icon(FontAwesome.cloud_upload,size: 30,color: Color(kLightBlue.value),),
          
              ),
              
              
              
              
              ),
        ));
  }
}
