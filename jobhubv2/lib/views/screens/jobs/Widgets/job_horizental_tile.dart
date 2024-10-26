import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jobhubv2_0/constants/app_constants.dart';
import 'package:jobhubv2_0/models/response/jobs/jobs_response.dart';
import 'package:jobhubv2_0/views/common/exports.dart';
import 'package:jobhubv2_0/views/common/height_spacer.dart';
import 'package:jobhubv2_0/views/common/width_spacer.dart';

class JobHorizentalTile extends StatelessWidget {
  const JobHorizentalTile({super.key, this.onTap, required this.job});

  final void Function()? onTap;
  final JobsResponse job;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(right: 12.w),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(12.w)),
          child: Container(
            height: hieght * 0.27,
            width: width * 0.7,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.w),
            decoration: BoxDecoration(
                color: Color(kLightGrey.value),
                image: const DecorationImage(
                  image: AssetImage('assets/images/jobs.png'),
                  fit: BoxFit.contain,
                  opacity: 0.5,
                )),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(job.imageUrl)),
                    const WidthSpacer(width: 15),
                    Container(
                      width: 150.w,
                      padding:
                          EdgeInsetsDirectional.symmetric(horizontal: 10.w),
                      decoration: BoxDecoration(
                        color: Color(kLight.value),
                        borderRadius: BorderRadius.all(Radius.circular(10.w)),
                      ),
                      child: ReusableText(
                          text: job.title,
                          style: appStyle(
                              12, Color(kDark.value), FontWeight.bold)),
                    )
                  ],
                ),
                const HeightSpacer(size: 25),
                ReusableText(
                    text: job.location,
                    style:
                        appStyle(14, Color(kDarkGrey.value), FontWeight.w600)),
                        const HeightSpacer(size: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ReusableText(
                            text: job.salary,
                            style:
                                appStyle(20, Color(kDark.value), FontWeight.w600)),
                        ReusableText(
                            text: "/${job.period}",
                            style: appStyle(
                                18, Color(kDarkGrey.value), FontWeight.w600))
                      ],
                    ),
                    CircleAvatar(radius: 18,backgroundColor: Color(kLight.value),child: const Icon(Icons.chevron_right),)
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
