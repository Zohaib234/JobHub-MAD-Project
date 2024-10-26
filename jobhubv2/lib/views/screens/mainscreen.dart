import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:jobhubv2_0/controllers/zoom_provider.dart';
import 'package:jobhubv2_0/views/common/drawer/drawerScreen.dart';
import 'package:jobhubv2_0/views/common/exports.dart';
import 'package:jobhubv2_0/views/common/reusable_text.dart';
import 'package:jobhubv2_0/views/screens/applications/applied_jobs.dart';
import 'package:jobhubv2_0/views/screens/auth/profile_page.dart';
import 'package:jobhubv2_0/views/screens/bookmarks/bookmarks.dart';
import 'package:jobhubv2_0/views/screens/chat/chat_list.dart';
import 'package:jobhubv2_0/views/screens/home/home_screen.dart';
import 'package:provider/provider.dart';

class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key});

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
        body: Consumer<ZoomNotifier>(
          builder: (context,zoomNotifier,child){
            return ZoomDrawer(
              
              menuScreen:DrawerScreen(indexSetter: (index){
                zoomNotifier.currentIndex=index;
              }) ,
             borderRadius: 30,
             menuBackgroundColor: Color(kLightBlue.value),
             angle: 0.0,
             slideWidth: 210,
            mainScreen: currentscreen());
          })

     );
    
  }
  Widget currentscreen(){
    var zoomNotifier = Provider.of<ZoomNotifier>(context);

    switch (zoomNotifier.currentIndex) {
      case 0:
      return const HomeScreen();
      case 1:
      return const ChatScreen();
      case 2:
      return const BookmarksScreen();
      case 3:
      return const AppliedJobs();
      case 4:
      return const ProfileScreen(drawer: true);

      default:
      return const HomeScreen();
    }
      }
}

