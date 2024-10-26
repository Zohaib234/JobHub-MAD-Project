import 'dart:ffi' as size;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jobhubv2_0/constants/app_constants.dart';
import 'package:jobhubv2_0/controllers/login_provider.dart';
import 'package:jobhubv2_0/controllers/zoom_provider.dart';
import 'package:jobhubv2_0/models/response/auth/profile_model.dart';
import 'package:jobhubv2_0/services/helpers/auth_helper.dart';
import 'package:jobhubv2_0/views/common/BackBtn.dart';
import 'package:jobhubv2_0/views/common/app_bar.dart';
import 'package:jobhubv2_0/views/common/app_style.dart';
import 'package:jobhubv2_0/views/common/custom_outline_btn.dart';
import 'package:jobhubv2_0/views/common/drawer/drawer_widget.dart';
import 'package:jobhubv2_0/views/screens/auth/widgets/edit_button.dart';
import 'package:jobhubv2_0/views/common/height_spacer.dart';
import 'package:jobhubv2_0/views/common/reusable_text.dart';
import 'package:jobhubv2_0/views/common/styled_container.dart';
import 'package:jobhubv2_0/views/common/width_spacer.dart';
import 'package:jobhubv2_0/views/screens/auth/guest_user.dart';
import 'package:jobhubv2_0/views/screens/auth/widgets/skills.dart';
import 'package:jobhubv2_0/views/screens/jobs/add_jobs.dart';
import 'package:jobhubv2_0/views/screens/mainscreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.drawer});

  final bool drawer;
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<ProfileRes>  userProfile;
  String username = "";
  @override
  void initState() {
    super.initState();
     userProfile =  getProfile();
    getName();
  }

  getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    username = prefs.getString('username') ?? " ";
    print(prefs.getString('token') ?? "");
  }

  Future<ProfileRes> getProfile() {
    var login = Provider.of<LoginNotifier>(context, listen: false);
    if (widget.drawer == false && login.getloggedIn == true) {
      return AuthHelper.getProfile();
    } else  {
      return AuthHelper.getProfile();
    }
  }

  @override
  Widget build(BuildContext context) {
    var zoom = Provider.of<ZoomNotifier>(context);
    var login = Provider.of<LoginNotifier>(context);

    print(login.getloggedIn);
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(50.h),
            child: CustomAppBar(
                text: login.getloggedIn ? username : " ",
                child: Padding(
                  padding: EdgeInsets.all(10.0.h),
                  child: widget.drawer
                      ? DrawerWidget(color: Color(kDark.value))
                      : const BackBtn(),
                ))),
        body: login.getloggedIn == false
            ? const GuestUser()
            : FutureBuilder(
                future: userProfile,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child: CircularProgressIndicator.adaptive());
                  } else if (snapshot.hasError) {
                    return Center(child: Column(
                      children: [
                        Text(snapshot.error.toString()),
                        CustomOutlineBtn(text: "log out", onTap: (){
                           zoom.currentIndex = 0;
                                login.logout();
                                Get.to(() => const Mainscreen());
                        } ,color: Color(kOrange.value)),
                      ],
                    ));
                  } else {
                    var profile = snapshot.data;
                    return buildStyleContainer(
                      context,
                      ListView(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        children: [
                          Container(
                            width: width,
                            height: hieght * 0.1,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.w)),
                                color: Color(kLightGrey.value)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage:
                                          NetworkImage(profile!.profile),
                                      radius: 30,
                                    ),
                                    const WidthSpacer(width: 10),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ReusableText(
                                            text: profile.username,
                                            style: appStyle(
                                                14,
                                                Color(kDarkGrey.value),
                                                FontWeight.w400)),
                                        ReusableText(
                                            text: profile.email,
                                            style: appStyle(
                                                14,
                                                Color(kDarkGrey.value),
                                                FontWeight.w400))
                                      ],
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                    onTap: () {}, child: const Icon(Icons.edit))
                              ],
                            ),
                          ),
                          const HeightSpacer(size: 20),
                          Stack(
                            children: [
                              Container(
                                height: hieght * 0.12,
                                width: width,
                                decoration:  BoxDecoration(
                                  borderRadius:
                                      const  BorderRadius.all(Radius.circular(12)),
                                      color: Color(kLightGrey.value)
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(left: 12.w),
                                      width: 60.w,
                                      height: 70.h,
                                      decoration: BoxDecoration(
                                        color: Color(kLight.value),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(12)),
                                      ),
                                      child: const Icon(
                                        Icons.picture_as_pdf,
                                        color: Colors.red,
                                        size: 40,
                                      ),
                                    ),
                                    const WidthSpacer(width: 20),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ReusableText(
                                            text: "Upload Your Resume",
                                            style: appStyle(
                                                16,
                                                Color(kDark.value),
                                                FontWeight.w500)),
                                        FittedBox(
                                          child: Text(
                                            "please make sure to upload your resume in PDF format",
                                            style: appStyle(
                                                8,
                                                Color(kDarkGrey.value),
                                                FontWeight.w500),
                                          ),
                                        )
                                      ],
                                    ),
                                    const WidthSpacer(width: 1),
                                  ],
                                ),
                              ),
                              Positioned(
                                right: 0.w,
                                child: EditButton(
                                  onTap: () {},
                                ),
                              ),
                            ],
                          ),
                          const HeightSpacer(size: 20),
                           
                           SkillsWidget(),

                          const HeightSpacer(size: 20),
                          profile.isAgent
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ReusableText(
                                        text: "Agent Information",
                                        style: appStyle(14, Color(kDark.value),
                                            FontWeight.w600))
                                  ],
                                )
                              : CustomOutlineBtn(
                                  width: width,
                                  hieght: 40.h,
                                  onTap: () {
                                  
                                  },
                                  text: "Apply to become an Agent",
                                  color: Color(kLightBlue.value)),
                          const HeightSpacer(size: 20),
                          CustomOutlineBtn(
                              width: width,
                              hieght: 40.h,
                              onTap: () {
                                 Get.to(()=>   AddJobs(AgentId: snapshot.data!.uid,) );
                              },
                              text: "Add Jobs",
                              color: Color(kLightBlue.value)),
                          const HeightSpacer(size: 20),
                          CustomOutlineBtn(
                              width: width,
                              hieght: 40.h,
                              onTap: () {
                                
                              },
                              text: "Update Information",
                              color: Color(kLightBlue.value)),
                          const HeightSpacer(size: 20),
                          CustomOutlineBtn(
                              width: width,
                              hieght: 40.h,
                              onTap: () {
                                zoom.currentIndex = 0;
                                login.logout();
                                Get.to(() => const Mainscreen());
                              },
                              text: "Proceed to logout",
                              color: Color(kLightBlue.value)),
                        ],
                      ),
                    );
                  }
                }));
  }
}
