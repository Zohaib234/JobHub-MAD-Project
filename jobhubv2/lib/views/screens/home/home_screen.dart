import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jobhubv2_0/constants/app_constants.dart';
import 'package:jobhubv2_0/controllers/login_provider.dart';
import 'package:jobhubv2_0/views/common/app_bar.dart';
import 'package:jobhubv2_0/views/common/app_style.dart';
import 'package:jobhubv2_0/views/common/drawer/drawer_widget.dart';
import 'package:jobhubv2_0/views/common/exports.dart';
import 'package:jobhubv2_0/views/common/heading_widget.dart';
import 'package:jobhubv2_0/views/common/reusable_text.dart';
import 'package:jobhubv2_0/views/common/search.dart';
import 'package:jobhubv2_0/views/screens/auth/login.dart';
import 'package:jobhubv2_0/views/screens/auth/profile_page.dart';
import 'package:jobhubv2_0/views/screens/jobs/Widgets/popular_jobs.dart';
import 'package:jobhubv2_0/views/screens/jobs/Widgets/recent_jobs.dart';
import 'package:jobhubv2_0/views/screens/jobs/job_list_page.dart';
import 'package:jobhubv2_0/views/screens/search/search_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String imageUrl =
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSCevVbi_1eUp1UaHjKO0AYUSEViJvIvjkTWwSdjwBoc8YZUR3cOiJHa8OX-brtOQ5IBuY&usqp=CAU';
  @override
  Widget build(BuildContext context) {
    var loginNotifier = Provider.of<LoginNotifier>(context);

    loginNotifier.getPref();
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(50.h),
            child: CustomAppBar(
                actions: [
                  GestureDetector(
                      onTap: () {
                        Get.to(() => const ProfileScreen(drawer: false));
                      },
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            loginNotifier.loggedIn == false
                                ? imageUrl
                                : profile),
                        radius: 12,
                      )),
                  const SizedBox(
                    width: 15,
                  )
                ],
                child: Padding(
                  padding: EdgeInsets.all(10.0.h),
                  child: DrawerWidget(color: Color(kDark.value)),
                ))),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Search \n Find & Apply",
                  style: appStyle(38, Color(kDark.value), FontWeight.bold),
                ),
                SizedBox(
                  height: 20.h,
                ),
                SearchWidget(
                  onTap: () {
                    Get.to(() => const SearchPage());
                  },
                ),
                SizedBox(
                  height: 30.h,
                ),
                HeadingWidget(
                  text: "Popular Jobs",
                  onTap: () {
                    Get.to(() => const JobListPage(
                          ispopular: true,
                        ));
                  },
                ),
                SizedBox(
                  height: 15.h,
                ),
                ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(12.w)),
                    child: const PopularJobs()),
                SizedBox(
                  height: 15.h,
                ),
                HeadingWidget(
                  text: "Recent Jobs",
                  onTap: () {
                    Get.to(() => const JobListPage(
                          ispopular: false,
                        ));
                  },
                ),
                SizedBox(
                  height: 15.h,
                ),
                RecentJobs(),
              ],
            ),
          ),
        )));
  }
}
