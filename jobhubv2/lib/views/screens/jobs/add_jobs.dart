import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:jobhubv2_0/constants/app_constants.dart';
import 'package:jobhubv2_0/controllers/skills_provider.dart';
import 'package:jobhubv2_0/controllers/zoom_provider.dart';
import 'package:jobhubv2_0/models/request/jobs/create_job.dart';
import 'package:jobhubv2_0/services/helpers/jobs_helper.dart';
import 'package:jobhubv2_0/views/common/BackBtn.dart';
import 'package:jobhubv2_0/views/common/app_bar.dart';
import 'package:jobhubv2_0/views/common/app_style.dart';
import 'package:jobhubv2_0/views/common/custom_outline_btn.dart';
import 'package:jobhubv2_0/views/common/height_spacer.dart';
import 'package:jobhubv2_0/views/common/reusable_text.dart';
import 'package:jobhubv2_0/views/common/styled_container.dart';
import 'package:jobhubv2_0/views/screens/mainscreen.dart';
import 'package:provider/provider.dart';

class AddJobs extends StatefulWidget {
  const AddJobs({
    super.key,
    this.AgentId,
  });

  final String? AgentId;

  @override
  State<AddJobs> createState() => _AddJobsState();
}

class _AddJobsState extends State<AddJobs> {
  TextEditingController title = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController contract = TextEditingController();
  TextEditingController sallery = TextEditingController();
  TextEditingController period = TextEditingController();
  TextEditingController agentName = TextEditingController();
  TextEditingController image = TextEditingController(
      text:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTIBQ_maaOvyQUl5nro8RAVy9wcF6tI1way9Q&s");

  TextEditingController rq1 = TextEditingController();
  TextEditingController rq2 = TextEditingController();
  TextEditingController rq3 = TextEditingController();
  TextEditingController rq4 = TextEditingController();
  TextEditingController rq5 = TextEditingController();
  TextEditingController rq6 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(kLightBlue.value),
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.h),
          child: CustomAppBar(
            text: "Upload a Job",
            titlecolor: kLight.value,
            color: Color(kLightBlue.value),
            actions: [
              Consumer<SkillsNotifier>(
                builder: (context, skills, child) {
                  return skills.logo.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(skills.getlogo),
                            radius: 15,
                          ),
                        )
                      : const SizedBox.shrink();
                },
              )
            ],
            child: const BackBtn(),
          )),
      body: Stack(
        children: [
          Positioned(
              top: 0,
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    color: Color(kLight.value)),
                child: buildStyleContainer(
                    context,
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12.w, vertical: 20),
                      child: ListView(
                        children: [
                          const HeightSpacer(size: 20),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: SizedBox(
                              height: 60,
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "please fill the field";
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: const InputDecoration(
                                    label: Text("Job Title"),
                                    hintText: "enter the Job Title",
                                    isDense: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    )),
                                controller: title,
                              ),
                            ),
                          ),
                          const HeightSpacer(size: 10),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: SizedBox(
                              height: 60,
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "please fill the field";
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: const InputDecoration(
                                    label: Text("Job location"),
                                    hintText: "enter the Job location",
                                    isDense: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    )),
                                controller: location,
                              ),
                            ),
                          ),
                          const HeightSpacer(size: 10),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: SizedBox(
                              height: 60,
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "please fill the field";
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: const InputDecoration(
                                    label: Text("Agent Name"),
                                    hintText: "enter the Agent Name",
                                    isDense: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    )),
                                controller: agentName,
                              ),
                            ),
                          ),
                          const HeightSpacer(size: 10),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: SizedBox(
                              height: 80,
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "please fill the field";
                                  } else {
                                    return null;
                                  }
                                },
                                maxLines: 3,
                                decoration: const InputDecoration(
                                    label: Text("Job description"),
                                    hintText: "enter the Job description",
                                    isDense: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    )),
                                controller: description,
                              ),
                            ),
                          ),
                          const HeightSpacer(size: 10),
                          Consumer<SkillsNotifier>(
                              builder: (context, skills, child) {
                            return SizedBox(
                              height: 60,
                              width: width,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: width * 0.8,
                                    height: 60,
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "please fill the field";
                                        } else {
                                          return null;
                                        }
                                      },
                                      decoration: const InputDecoration(
                                          label: Text("Image Url"),
                                          hintText: "enter the image url",
                                          isDense: true,
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                          )),
                                      controller: image,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      skills.setlogo(image.text);
                                    },
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 12.0),
                                      child: Icon(
                                        Icons.cloud_upload,
                                        color: Color(kLightBlue.value),
                                        size: 35,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          }),
                          const HeightSpacer(size: 10),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: SizedBox(
                              height: 60,
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "please fill the field";
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: const InputDecoration(
                                    label: Text("Job contract"),
                                    hintText: "enter the Job contract",
                                    isDense: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    )),
                                controller: contract,
                              ),
                            ),
                          ),
                          const HeightSpacer(size: 10),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: SizedBox(
                              height: 60,
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "please fill the field";
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: const InputDecoration(
                                    label: Text("Job sallery"),
                                    hintText: "enter the Job sallery",
                                    isDense: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    )),
                                controller: sallery,
                              ),
                            ),
                          ),
                          const HeightSpacer(size: 10),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: SizedBox(
                              height: 60,
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "please fill the field";
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: const InputDecoration(
                                    label: Text("Job period"),
                                    hintText: "enter the Job period",
                                    isDense: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    )),
                                controller: period,
                              ),
                            ),
                          ),
                          ReusableText(
                              text: "Job Requirements",
                              style: appStyle(
                                  16, Color(kDark.value), FontWeight.w500)),
                          const HeightSpacer(size: 10),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: SizedBox(
                              height: 60,
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "please fill the field";
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: const InputDecoration(
                                    label: Text("Requirement 1"),
                                    hintText: "enter the Requirement 1",
                                    isDense: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    )),
                                controller: rq1,
                              ),
                            ),
                          ),
                          const HeightSpacer(size: 10),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: SizedBox(
                              height: 60,
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "please fill the field";
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: const InputDecoration(
                                    label: Text("Requirement 2"),
                                    hintText: "enter the Requirement 2",
                                    isDense: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    )),
                                controller: rq2,
                              ),
                            ),
                          ),
                          const HeightSpacer(size: 10),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: SizedBox(
                              height: 60,
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "please fill the field";
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: const InputDecoration(
                                    label: Text("Requirement 3"),
                                    hintText: "enter the Requirement 3",
                                    isDense: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    )),
                                controller: rq3,
                              ),
                            ),
                          ),
                          const HeightSpacer(size: 10),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: SizedBox(
                              height: 60,
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "please fill the field";
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: const InputDecoration(
                                    label: Text("Requirement 4"),
                                    hintText: "enter the Requirement 4",
                                    isDense: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    )),
                                controller: rq4,
                              ),
                            ),
                          ),
                          const HeightSpacer(size: 10),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: SizedBox(
                              height: 60,
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "please fill the field";
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: const InputDecoration(
                                    label: Text("Requirement 5"),
                                    hintText: "enter the Requirement 5",
                                    isDense: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    )),
                                controller: rq5,
                              ),
                            ),
                          ),
                          const HeightSpacer(size: 10),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: SizedBox(
                              height: 60,
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "please fill the field";
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: const InputDecoration(
                                    label: Text("Last Requirement"),
                                    hintText: "enter the Last Requirement",
                                    isDense: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    )),
                                controller: rq6,
                              ),
                            ),
                          ),
                          const HeightSpacer(size: 10),
                          CustomOutlineBtn(
                              onTap: () {
                                var zoom = Provider.of<ZoomNotifier>(context,
                                    listen: false);
                                var skill = Provider.of<SkillsNotifier>(context,
                                    listen: false);
                                CreateJobsRequest rawmodel = CreateJobsRequest(
                                    title: title.text,
                                    location: location.text,
                                    hiring: true,
                                    description: description.text,
                                    salary: sallery.text,
                                    period: period.text,
                                    agentName: agentName.text,
                                    contract: contract.text,
                                    imageUrl: skill.getlogo,
                                    agentId: widget.AgentId != null ? " " : " ",
                                    requirements: [
                                      rq1.text,
                                      rq2.text,
                                      rq3.text,
                                      rq4.text,
                                      rq5.text,
                                      rq6.text
                                    ]);
                                var model = createJobsRequestToJson(rawmodel);
                                JobsHelper.createJob(model);
                                zoom.currentIndex = 0;
                                Get.to(() => const Mainscreen());
                              },
                              hieght: 60,
                              text: "Submit",
                              color: Color(kLightBlue.value))
                        ],
                      ),
                    )),
              )),
        ],
      ),
    );
  }
}
