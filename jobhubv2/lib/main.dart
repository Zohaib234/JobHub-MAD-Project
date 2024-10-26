import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:jobhubv2_0/constants/app_constants.dart';
import 'package:jobhubv2_0/controllers/agent_provider.dart';
import 'package:jobhubv2_0/controllers/bookmark_provider.dart';
import 'package:jobhubv2_0/controllers/image_provider.dart';
import 'package:jobhubv2_0/controllers/jobs_provider.dart';
import 'package:jobhubv2_0/controllers/login_provider.dart';
import 'package:jobhubv2_0/controllers/onboarding_provider.dart';
import 'package:jobhubv2_0/controllers/profile_provider.dart';
import 'package:jobhubv2_0/controllers/signup_provider.dart';
import 'package:jobhubv2_0/controllers/skills_provider.dart';
import 'package:jobhubv2_0/controllers/zoom_provider.dart';
import 'package:jobhubv2_0/firebase_options.dart';
import 'package:jobhubv2_0/views/screens/mainscreen.dart';
import 'package:jobhubv2_0/views/screens/onboarding/onboarding_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget defaultHome = const OnboardingScreen();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SharedPreferences preferences = await SharedPreferences.getInstance();
  final entrypoint = preferences.getBool('entrypoint') ?? false;
  if (entrypoint) {
    defaultHome = const Mainscreen();
  }

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => OnBoardNotifier()),
    ChangeNotifierProvider(create: (context) => LoginNotifier()),
    ChangeNotifierProvider(create: (context) => ZoomNotifier()),
    ChangeNotifierProvider(create: (context) => SignUpNotifier()),
    ChangeNotifierProvider(create: (context) => JobsNotifier()),
    ChangeNotifierProvider(create: (context) => ImageUpoader()),
    ChangeNotifierProvider(create: (context) => ProfileNotifier()),
    ChangeNotifierProvider(create: (context) => BookmarkNotifier()),
    ChangeNotifierProvider(create: (context) => SkillsNotifier()),
    ChangeNotifierProvider(create: (context) => AgentNotifier()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        useInheritedMediaQuery: true,
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'JobHub',
            theme: ThemeData(
              scaffoldBackgroundColor: Color(kLight.value),
              iconTheme: IconThemeData(color: Color(kDark.value)),
              primarySwatch: Colors.grey,
            ),
            home: defaultHome,
          );
        });
  }
}
