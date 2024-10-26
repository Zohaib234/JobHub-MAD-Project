import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jobhubv2_0/constants/app_constants.dart';
import 'package:jobhubv2_0/controllers/onboarding_provider.dart';
import 'package:jobhubv2_0/views/screens/onboarding/widget/PageOne.dart';
import 'package:jobhubv2_0/views/screens/onboarding/widget/PageThree.dart';
import 'package:jobhubv2_0/views/screens/onboarding/widget/PageTwo.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController pagecontroller = PageController();

  @override
  void dispose() {
    pagecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:Consumer<OnBoardNotifier>(builder:(context,OnBoardNotifier,child){
        return  Stack(
        children: [
          PageView(
            controller: pagecontroller,
            physics: OnBoardNotifier.islastpage? const NeverScrollableScrollPhysics():const AlwaysScrollableScrollPhysics(),
            onPageChanged: (page){
              OnBoardNotifier.islastpage=page==2;           
            },
            children: const [PageOne(), PageTwo(), PageThree()],
          ),
        
          OnBoardNotifier.islastpage?const SizedBox.shrink(): Positioned(
            bottom: hieght*0.018,
            left: 0,
            right: 0,
            
            child: Center(
              child: SmoothPageIndicator(controller: pagecontroller, count: 3,
              effect: WormEffect(
                dotColor: Color(kLight.value),
                activeDotColor: Color(kOrange.value),
                dotHeight: 12,
                dotWidth: 12,
                spacing: 10
              ) ,
              ),
            )),
          const Positioned(child: Center())
        ],
              );
      } )
    );
  }
}
