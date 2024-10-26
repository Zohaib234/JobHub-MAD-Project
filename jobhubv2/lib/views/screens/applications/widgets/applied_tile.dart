import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:jobhubv2_0/constants/app_constants.dart';
import 'package:jobhubv2_0/models/response/applied/applied.dart';
import 'package:jobhubv2_0/views/common/app_style.dart';
import 'package:jobhubv2_0/views/common/reusable_text.dart';
import 'package:jobhubv2_0/views/screens/jobs/job_details.dart';

class AppliedTile extends StatelessWidget {
  const AppliedTile({super.key, required this.appliedJobs});

  final Applied appliedJobs;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => JobDetails(
            id: appliedJobs.job.id,
            title: appliedJobs.job.title,
            agentName: appliedJobs.job.agentName));
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: Container(
          height: hieght * 0.1,
          width: width,
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
          decoration: BoxDecoration(
            color: Color(kLightGrey.value),
            borderRadius: BorderRadius.all(Radius.circular(9.w)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(appliedJobs.job.imageUrl),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ReusableText(
                              text: appliedJobs.job.title,
                              style: appStyle(
                                  14, Color(kDark.value), FontWeight.w500)),
                          SizedBox(
                            width: width * 0.5,
                          ),
                          ReusableText(
                              text: appliedJobs.job.location,
                              style: appStyle(
                                  12, Color(kDarkGrey.value), FontWeight.w500)),
                          ReusableText(
                              text:
                                  "${appliedJobs.job.salary} per ${appliedJobs.job.period} ",
                              style: appStyle(
                                  12, Color(kDarkGrey.value), FontWeight.w500)),
                        ],
                      )
                    ],
                  ),
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: Color(kLight.value),
                    child: const Icon(Icons.chevron_right),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
