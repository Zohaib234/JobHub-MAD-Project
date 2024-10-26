import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jobhubv2_0/constants/app_constants.dart';
import 'package:jobhubv2_0/controllers/agent_provider.dart';
import 'package:jobhubv2_0/models/response/agent/getAgent.dart';
import 'package:jobhubv2_0/services/helpers/agent_helper.dart';
import 'package:jobhubv2_0/views/common/BackBtn.dart';
import 'package:jobhubv2_0/views/common/app_style.dart';
import 'package:jobhubv2_0/views/common/height_spacer.dart';
import 'package:jobhubv2_0/views/common/reusable_text.dart';
import 'package:jobhubv2_0/views/common/width_spacer.dart';
import 'package:jobhubv2_0/views/screens/agents/agent_jobs.dart';
import 'package:provider/provider.dart';

class AgentDetails extends StatefulWidget {
  const AgentDetails({super.key, required this.uid});

  final String uid;

  @override
  State<AgentDetails> createState() => _AgentDetailsState();
}

class _AgentDetailsState extends State<AgentDetails> {
  Future<List<GetAgent>>? agentInfo;

  @override
  void initState() {
    super.initState();
    agentInfo = AgentHelper.getAgent(widget.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff171717),
      appBar: AppBar(
        backgroundColor: const Color(0xff171717),
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.all(12.w),
          child: BackBtn(
            color: Color(kLight.value),
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.only(left: 12.w, right: 12.w),
                height: 160.h,
                decoration: BoxDecoration(
                  color: Color(kLightBlue.value),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.w),
                    topRight: Radius.circular(20.w),
                  ),
                ),
                child: Column(
                  children: [
                    Consumer<AgentNotifier>(
                        builder: (context, agentnotifier, child) {
                      return Padding(
                        padding: EdgeInsets.all(8.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ReusableText(
                                        text: "Company",
                                        style: appStyle(10, Color(kLight.value),
                                            FontWeight.w500)),
                                    ReusableText(
                                        text: "Address",
                                        style: appStyle(10, Color(kLight.value),
                                            FontWeight.w500)),
                                    ReusableText(
                                        text: "Working Hours",
                                        style: appStyle(10, Color(kLight.value),
                                            FontWeight.w500)),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.w),
                                  child: Container(
                                    height: 60.w,
                                    width: 1.w,
                                    color: Colors.amberAccent,
                                  ),
                                ),
                                FutureBuilder<List<GetAgent>>(
                                    future: agentInfo,
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const SizedBox.shrink();
                                      } else if (snapshot.hasError) {
                                        print(snapshot.error.toString());
                                        return Text("error occured");
                                      } else {
                                        var agentdata = snapshot.data![0];

                                        return Column(
                                          children: [
                                            ReusableText(
                                                text: agentdata.company,
                                                style: appStyle(
                                                    10,
                                                    Color(kLight.value),
                                                    FontWeight.w500)),
                                            ReusableText(
                                                text: agentdata.hqAddress,
                                                style: appStyle(
                                                    10,
                                                    Color(kLight.value),
                                                    FontWeight.w500)),
                                            ReusableText(
                                                text: agentdata.workingHrs,
                                                style: appStyle(
                                                    10,
                                                    Color(kLight.value),
                                                    FontWeight.w500)),
                                          ],
                                        );
                                      }
                                    }),
                                const WidthSpacer(width: 50),
                                CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      agentnotifier.agent!.profile),
                                )
                              ],
                            ),
                          ],
                        ),
                      );
                    })
                  ],
                ),
              )),
          Positioned(
              top: 90,
              left: 0,
              right: 0,
              child: Container(
                height: hieght,
                width: width,
                
                decoration: BoxDecoration(
                  color: Color(kLight.value),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.w),
                    topRight: Radius.circular(20.w),
                  ),
                ),
                child: const AgentJobs(),
              ))
        ],
      ),
    );
  }
}
