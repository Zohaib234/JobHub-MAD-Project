

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:jobhubv2_0/controllers/skills_provider.dart';
import 'package:jobhubv2_0/models/request/auth/add_skills.dart';
// import 'package:jobhubv2_0/controllers/zoom_provider.dart';
import 'package:jobhubv2_0/models/response/auth/skills.dart';
import 'package:jobhubv2_0/services/helpers/auth_helper.dart';
import 'package:jobhubv2_0/views/common/exports.dart';
import 'package:jobhubv2_0/views/common/height_spacer.dart';
import 'package:jobhubv2_0/views/common/width_spacer.dart';
import 'package:jobhubv2_0/views/screens/auth/widgets/add_skills.dart';
import 'package:provider/provider.dart';

class SkillsWidget extends StatefulWidget {
  const SkillsWidget({super.key});

  @override
  State<SkillsWidget> createState() => _SkillsState();
}

class _SkillsState extends State<SkillsWidget> {
  TextEditingController skills = TextEditingController();
  late Future<List<Skills>> userskills;

  @override
  void initState() {
    super.initState();
    userskills = getSkills();
  }

  Future<List<Skills>> getSkills() {
    var skill = AuthHelper.getSkills();
    return skill;
  }

  @override
  Widget build(BuildContext context) {
    // var zoom = Provider.of<ZoomNotifier>(context);
    var skillsnotifier = Provider.of<SkillsNotifier>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(4.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ReusableText(
                  text: "Skills",
                  style: appStyle(15, Color(kDark.value), FontWeight.w600)),
              Consumer<SkillsNotifier>(builder: (context, skills, child) {
                return skills.getskills != true
                    ? GestureDetector(
                        onTap: () {
                          skills.setskills = !skills.getskills;
                        },
                        child: const Icon(Icons.add_circle_outline_rounded),
                      )
                    : GestureDetector(
                        onTap: () {
                          skills.setskills = !skills.getskills;
                        },
                        child: const Icon(Icons.close_rounded),
                      );
              })
            ],
          ),
        ),
        const HeightSpacer(size: 10),
        skillsnotifier.getskills == true
            ? AddSkillsWidget(skill: skills,onTap: (){
              // AddSkill rawmodel  = AddSkill(skill: skills.text);
              // var model = addSkillToJson(rawmodel);
              // AuthHelper.addSkill(model);
              // skillsnotifier.setskills = !skillsnotifier.getskills;
              // userskills = getSkills();
              
            },)
            : SizedBox(
                height: 34.w,
                child: FutureBuilder(
                    future: userskills,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return Text("Error: ${snapshot.error}");
                      } else {
                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              var skill = snapshot.data![index];
                              return GestureDetector(
                                onLongPress: () {
                                  skillsnotifier.setskillsId = skill.id;
                                },
                                onTap: () {
                                  skillsnotifier.setskillsId = '';
                                },
                                child: Container(
                                  padding: EdgeInsets.all(5.w),
                                  margin: EdgeInsets.all(4.w),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15.w)),
                                      color: Color(kLightGrey.value)),
                                  child: Row(
                                    children: [
                                      ReusableText(
                                          text: skill.skill,
                                          style: appStyle(
                                              10,
                                              Color(kDark.value),
                                              FontWeight.w500)),
                                      const WidthSpacer(width: 5),
                                      skillsnotifier.getskillsId == skill.id
                                          ? GestureDetector(
                                              onTap: (){
                                                // print(skillsnotifier.getskillsId);
                                                // AuthHelper.deleteSkill(skill.id);
                                                // skillsnotifier.setskillsId = '';
                                                // userskills = getSkills();
                                              },
                                              child: Icon(
                                                FontAwesome.remove,
                                                size: 14,
                                                color: Color(kDark.value),
                                              ),
                                            )
                                          : const SizedBox.shrink()
                                    ],
                                  ),
                                ),
                              );
                            });
                      }
                    }),
              )
      ],
    );
  }
}
