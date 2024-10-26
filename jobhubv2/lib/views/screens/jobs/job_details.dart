import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jobhubv2_0/constants/app_constants.dart';
import 'package:jobhubv2_0/controllers/bookmark_provider.dart';
import 'package:jobhubv2_0/controllers/jobs_provider.dart';
import 'package:jobhubv2_0/controllers/login_provider.dart';
import 'package:jobhubv2_0/controllers/zoom_provider.dart';
import 'package:jobhubv2_0/models/request/applied/applied.dart';
import 'package:jobhubv2_0/models/response/bookmarks/book_res.dart';
import 'package:jobhubv2_0/models/response/jobs/get_job.dart';
import 'package:jobhubv2_0/services/firebase_services.dart';
import 'package:jobhubv2_0/services/helpers/applied_helper.dart';
import 'package:jobhubv2_0/views/common/BackBtn.dart';
import 'package:jobhubv2_0/views/common/app_bar.dart';
import 'package:jobhubv2_0/views/common/app_style.dart';
import 'package:jobhubv2_0/views/common/custom_outline_btn.dart';
import 'package:jobhubv2_0/views/common/height_spacer.dart';
import 'package:jobhubv2_0/views/common/reusable_text.dart';
import 'package:jobhubv2_0/views/common/styled_container.dart';
import 'package:jobhubv2_0/views/screens/auth/login.dart';
import 'package:jobhubv2_0/views/screens/jobs/update_job.dart';
import 'package:jobhubv2_0/views/screens/mainscreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JobDetails extends StatefulWidget {
  const JobDetails(
      {super.key,
      required this.id,
      required this.title,
      required this.agentName});
  final String id;
  final String title;
  final String agentName;

  @override
  State<JobDetails> createState() => _JobDetailsState();
}

class _JobDetailsState extends State<JobDetails> {
  bool isagent = false;
  FirebaseServices services = FirebaseServices();

  createChat(Map<String, dynamic> jobDetails, List<String> users,
      String chatRoomId, String messageType) {
    Map<String, dynamic> chatData = {
      'users': users,
      'chatRoomId': chatRoomId,
      'read': false,
      'job': jobDetails,
      'profile': profile,
      'sender': userId,
      'name': username,
      'agentName': widget.agentName,
      'messageType': messageType,
      'lastChat': "Good day sir , i am interested in this job",
      'lastChatTime': Timestamp.now()
    };
    services.createChatRoom(chatData: chatData);
  }

  @override
  void initState() {
    super.initState();
    getPrefs();
    final jobsNotifier = Provider.of<JobsNotifier>(context, listen: false);
    final bookmarknotifier =
        Provider.of<BookmarkNotifier>(context, listen: false);
    bookmarknotifier.getBookMark(widget.id);
    jobsNotifier.getJob(widget.id);
  }

  void getPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isagent = prefs.getBool('isAgent') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    var login = Provider.of<LoginNotifier>(context);
    var zoom = Provider.of<ZoomNotifier>(context);
    login.getPref();
    return Consumer<JobsNotifier>(builder: (context, jobsNotifier, child) {
      return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: CustomAppBar(actions: [
              login.getloggedIn == false
                  ? const SizedBox.shrink()
                  : Consumer<BookmarkNotifier>(
                      builder: (context, bookmark, child) {
                      return GestureDetector(
                        onTap: () {
                          if (bookmark.getbookmark == true) {
                            bookmark.deleteBookMark(widget.id);
                          } else {
                            BookMarkReqRes model =
                                BookMarkReqRes(job: widget.id);
                            var newmodel = bookMarkReqResToJson(model);
                            bookmark.addBookMark(newmodel);
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.only(right: 12.w),
                          child: Icon(bookmark.getbookmark == false
                              ? Icons.bookmark_border_outlined
                              : Icons.bookmark),
                        ),
                      );
                    })
            ], child: const BackBtn())),
        body: buildStyleContainer(
            context,
            FutureBuilder<GetJobRes>(
                future: jobsNotifier.job,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child: CircularProgressIndicator.adaptive());
                  } else if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  } else {
                    final job = snapshot.data;
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Stack(
                        children: [
                          ListView(
                            padding: EdgeInsets.zero,
                            children: [
                              Container(
                                width: width,
                                height: hieght * 0.27,
                                decoration: BoxDecoration(
                                    color: Color(kLightGrey.value),
                                    image: const DecorationImage(
                                        image: AssetImage(
                                            'assets/images/jobs.png'),
                                        opacity: 0.35),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(9.w))),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: 30.w,
                                      backgroundImage:
                                          NetworkImage(job!.imageUrl),
                                    ),
                                    const HeightSpacer(size: 10),
                                    ReusableText(
                                        text: job.title,
                                        style: appStyle(16, Color(kDark.value),
                                            FontWeight.w600)),
                                    const HeightSpacer(size: 5),
                                    ReusableText(
                                        text: job.location,
                                        style: appStyle(
                                            16,
                                            Color(kDarkGrey.value),
                                            FontWeight.w600)),
                                    const HeightSpacer(size: 15),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 50),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CustomOutlineBtn(
                                              hieght: hieght * 0.04,
                                              width: width * .26,
                                              text: job.contract,
                                              color: Color(kOrange.value)),
                                          Row(
                                            children: [
                                              ReusableText(
                                                  text: job.salary,
                                                  style: appStyle(
                                                      16,
                                                      Color(kDark.value),
                                                      FontWeight.w600)),
                                              ReusableText(
                                                  text: "/${job.period}",
                                                  style: appStyle(
                                                      16,
                                                      Color(kDarkGrey.value),
                                                      FontWeight.w600))
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const HeightSpacer(size: 20),
                              ReusableText(
                                  text: "Description",
                                  style: appStyle(
                                      16, Color(kDark.value), FontWeight.w600)),
                              const HeightSpacer(size: 10),
                              Text(
                                job.description,
                                maxLines: 9,
                                textAlign: TextAlign.justify,
                                style: appStyle(12, Color(kDarkGrey.value),
                                    FontWeight.normal),
                              ),
                              const HeightSpacer(size: 20),
                              ReusableText(
                                  text: "Requirements",
                                  style: appStyle(
                                      16, Color(kDark.value), FontWeight.w600)),
                              const HeightSpacer(size: 10),
                              SizedBox(
                                height: hieght * .6,
                                child: ListView.builder(
                                    itemCount: job.requirements.length,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      var requirement = job.requirements[index];
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 12),
                                        child: Text(
                                          requirement,
                                          style: appStyle(
                                              12,
                                              Color(kDarkGrey.value),
                                              FontWeight.normal),
                                        ),
                                      );
                                    }),
                              )
                            ],
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                                padding: EdgeInsets.only(bottom: 15.0.w),
                                child: isagent
                                    ? CustomOutlineBtn(
                                        onTap: () {
                                          updateJob = job;
                                          Get.to(() => const UpdateJob());
                                        },
                                        text: "Edit Job",
                                        color: Color(kLight.value),
                                        hieght: hieght * 0.05,
                                        color2: Color(kOrange.value),
                                      )
                                    : CustomOutlineBtn(
                                        onTap: () async {
                                          if (login.getloggedIn) {
                                            Map<String, dynamic> jobDetails = {
                                              'job_id': job.id,
                                              'image_url': job.imageUrl,
                                              'salary':
                                                  "${job.salary} per ${job.period}",
                                              "title": job.title,
                                              'description': job.description
                                            };

                                            List<String> users = [
                                              job.agentId,
                                              userId
                                            ];

                                            String chatRoomId =
                                                '${job.id}.$userId';

                                            bool doesChatExist = await services
                                                .chatRoomExists(chatRoomId);

                                            if (doesChatExist == false) {
                                              createChat(jobDetails, users,
                                                  chatRoomId, 'text');
                                              var rawmodel =
                                                  AppliedPost(job: job.id);
                                              String model =
                                                  appliedPostToJson(rawmodel);
                                              AppliedHelper.applyJob(model);
                                              zoom.currentIndex = 0;
                                              Get.to(() => const Mainscreen());
                                            }
                                          } else {
                                            Get.to(() => const LoginPage());
                                          }
                                        },
                                        text: login.getloggedIn == false
                                            ? "Please Login"
                                            : "apply for job",
                                        color: Color(kLight.value),
                                        hieght: hieght * 0.05,
                                        color2: Color(kOrange.value),
                                      )),
                          )
                        ],
                      ),
                    );
                  }
                })),
      );
    });
  }
}
