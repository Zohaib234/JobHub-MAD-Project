import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:jobhubv2_0/constants/app_constants.dart';
import 'package:jobhubv2_0/controllers/agent_provider.dart';
import 'package:jobhubv2_0/controllers/login_provider.dart';
import 'package:jobhubv2_0/models/request/agents/agents.dart';
import 'package:jobhubv2_0/services/firebase_services.dart';
import 'package:jobhubv2_0/utils/date.dart';
import 'package:jobhubv2_0/views/common/app_style.dart';
import 'package:jobhubv2_0/views/common/drawer/drawer_widget.dart';
import 'package:jobhubv2_0/views/common/height_spacer.dart';
import 'package:jobhubv2_0/views/common/loader.dart';
import 'package:jobhubv2_0/views/common/reusable_text.dart';
import 'package:jobhubv2_0/views/common/width_spacer.dart';
import 'package:jobhubv2_0/views/screens/agents/agent_details.dart';
import 'package:jobhubv2_0/views/screens/auth/guest_user.dart';
import 'package:jobhubv2_0/views/screens/chat/chat_page.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  late TabController controller = TabController(length: 3, vsync: this);
  Future<List<Agents>>? agents;

  String imageUrl =
      "https://img.freepik.com/premium-photo/hooded-hacker-orchestrates-daring-cyber-attack-cyber-security-with-digital-waves_226666-119.jpg";

  FirebaseServices services = FirebaseServices();

  final Stream<QuerySnapshot> _chat = FirebaseFirestore.instance
      .collection('chats')
      .where('user', arrayContains: userId)
      .snapshots();

  @override
  void initState() {
    super.initState();
    agents = AgentNotifier().getAllAgents();
  }

  @override
  Widget build(BuildContext context) {
    var login = Provider.of<LoginNotifier>(context);
    return Scaffold(
      backgroundColor: const Color(0xff171717),
      appBar: AppBar(
        backgroundColor: const Color(0xff171717),
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.all(12.w),
          child: DrawerWidget(color: Color(kLight.value)),
        ),
        title: login.getloggedIn
            ? TabBar(
                controller: controller,
                indicator: BoxDecoration(
                  color: const Color(0x00BABABA),
                  borderRadius: BorderRadius.all(Radius.circular(12.w)),
                ),
                labelColor: Color(kLight.value),
                unselectedLabelColor: Colors.grey.withOpacity(0.5),
                padding: EdgeInsets.all(3.w),
                labelStyle: appStyle(12, Color(kLight.value), FontWeight.w500),
                dividerColor: Colors.transparent,
                tabs: const [
                    Tab(
                      text: "MESSAGE",
                    ),
                    Tab(
                      text: "ONLINE",
                    ),
                    Tab(
                      text: "GROUPS",
                    ),
                  ])
            : const SizedBox.shrink(),
      ),
      body: login.getloggedIn == false
          ? const GuestUser()
          : TabBarView(controller: controller, children: [
              Stack(
                children: [
                  Positioned(
                      top: 20,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding:
                            EdgeInsets.only(top: 15.w, left: 25.w, right: 0.w),
                        height: 220.h,
                        decoration: BoxDecoration(
                          color: Color(kLightBlue.value),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.w),
                            topRight: Radius.circular(20.w),
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ReusableText(
                                    text: "Agents and Companies",
                                    style: appStyle(12, Color(kLight.value),
                                        FontWeight.normal)),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Bootstrap.three_dots,
                                    color: Color(kLight.value),
                                  ),
                                )
                              ],
                            ),
                            Consumer<AgentNotifier>(
                                builder: (context, agentnotifier, child) {
                              return FutureBuilder<List<Agents>>(
                                  future: agents,
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Center(
                                          child: CircularProgressIndicator
                                              .adaptive());
                                    } else if (snapshot.hasError) {
                                      return Center(
                                          child:
                                              Text(snapshot.error.toString()));
                                    } else {
                                      return SizedBox(
                                        height: 90.h,
                                        child: ListView.builder(
                                            itemCount: snapshot.data!.length,
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, index) {
                                              var agent = snapshot.data![index];
                                              return GestureDetector(
                                                onTap: () {
                                                  agentnotifier.setAgent(agent);
                                                  Get.to(() => AgentDetails(
                                                      uid: agent.uid));
                                                },
                                                child: agentAvator(
                                                    agent.username,
                                                    agent.profile),
                                              );
                                            }),
                                      );
                                    }
                                  });
                            })
                          ],
                        ),
                      )),
                  Positioned(
                      top: 150,
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
                          child: StreamBuilder<QuerySnapshot>(
                              stream: _chat,
                              builder: (BuildContext context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child:
                                          CircularProgressIndicator.adaptive());
                                } else if (snapshot.hasError) {
                                  return Center(
                                      child: Text(snapshot.error.toString()));
                                } else if (snapshot.data!.docs.isEmpty) {
                                  return const NoSearchResults(
                                      text: "no chats available");
                                } else {
                                  final chatlist = snapshot.data!.docs;
                                  return ListView.builder(
                                      itemCount: chatlist.length,
                                      padding: EdgeInsets.only(left: 25.w),
                                      shrinkWrap: true,
                                      itemBuilder: ((context, index) {
                                        final chat = chatlist[index].data()
                                            as Map<String, dynamic>;

                                        Timestamp lastmessage =
                                            chat['lastChatTime'];
                                        DateTime lastmessagetime =
                                            lastmessage.toDate();
                                        return Consumer<AgentNotifier>(builder:
                                            (context, agentnotifier, child) {
                                          return GestureDetector(
                                              onTap: () {
                                                if (chat['sender'] != userId) {
                                                  services.updateCount(chat['chatRoomId']);
                                                } else {
                                                  agentnotifier.chat = chat;
                                                  Get.to(()=> const ChatPage());
                                                }            
                                              },
                                              child: buildChatRow(
                                                  username == chat['name']
                                                      ? chat['agentName']
                                                      : chat['name'],
                                                  chat['lastChat'],
                                                  chat['profile'],
                                                  chat['read'] == false ? 0 : 1,
                                                  lastmessagetime));
                                        });
                                      }));
                                }
                              })))
                ],
              ),
              Container(
                height: hieght,
                decoration: const BoxDecoration(color: Colors.green),
              ),
              Container(
                height: hieght,
                decoration: const BoxDecoration(color: Colors.white),
              )
            ]),
    );
  }
}

Widget agentAvator(String name, String profile) {
  return Padding(
    padding: EdgeInsets.only(right: 20.w),
    child: Column(
      children: [
        Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(99.w)),
                border: Border.all(
                  width: 1.5,
                  color: Color(kLight.value),
                )),
            child: CircleAvatar(
              backgroundImage: NetworkImage(profile),
              radius: 25,
            )),
        const HeightSpacer(size: 7),
        ReusableText(
            text: name,
            style: appStyle(12, Color(kLight.value), FontWeight.normal))
      ],
    ),
  );
}

Widget buildChatRow(
    String name, String message, String filename, int msgcount, time) {
  return Column(
    children: [
      FittedBox(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(filename),
                  radius: 25,
                ),
                const WidthSpacer(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReusableText(
                        text: name,
                        style: appStyle(12, Colors.grey, FontWeight.w400)),
                    const HeightSpacer(size: 5),
                    SizedBox(
                      width: width * 0.65,
                      child: ReusableText(
                          text: message,
                          style: appStyle(12, Colors.grey, FontWeight.w400)),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(right: 10.w, left: 15.w, top: 5.w),
              child: Column(
                children: [
                  ReusableText(
                      text: duTimeLineFormat(time),
                      style: appStyle(10, Colors.black, FontWeight.normal)),
                  const HeightSpacer(size: 15),
                  if (msgcount > 0)
                    CircleAvatar(
                      radius: 7,
                      backgroundColor: Color(kDarkBlue.value),
                      child: ReusableText(
                          text: msgcount.toString(),
                          style: appStyle(
                              8, Color(kLight.value), FontWeight.normal)),
                    )
                ],
              ),
            )
          ],
        ),
      ),
      const Divider(
        indent: 70,
        height: 20,
      )
    ],
  );
}
