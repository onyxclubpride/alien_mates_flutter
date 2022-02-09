import 'package:alien_mates/mgr/navigation/app_routes.dart';
import 'package:alien_mates/mgr/redux/action.dart';
import 'package:alien_mates/mgr/redux/app_state.dart';
import 'package:alien_mates/presentation/template/base/template.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intro_slider/intro_slider.dart';

import 'package:intro_slider/slide_object.dart';
import 'package:intro_slider/scrollbar_behavior_enum.dart';
import 'package:lottie/lottie.dart';

class IntroPage extends StatefulWidget {
  @override
  IntroPageState createState() => IntroPageState();
}

// ------------------ Custom config ------------------
class IntroPageState extends State<IntroPage> {
  List<Slide> slides = [];
  DateTime timeBackPressed = DateTime.now();

  bool isliking = false;
  String likingpostid = "";
  bool startLiking = false;

  @override
  void initState() {
    super.initState();
    slides.add(Slide(
      backgroundColor: ThemeColors.coolgray600,
      centerWidget: Column(
        children: [
          SizedText(
            text: 'Welcome to',
            textStyle: latoM20.copyWith(color: ThemeColors.coolgray100),
          ),
          LottieBuilder.asset(
            'assets/lotties/hello_lottie.json',
            reverse: true,
            repeat: true,
            frameRate: FrameRate.composition,
          ),
          SizedText(
            text: 'ALIEN MATES',
            textStyle: latoB34.copyWith(color: ThemeColors.coolgray100),
          )
        ],
      ),
    ));
    slides.add(Slide(
      backgroundColor: ThemeColors.coolgray600,
      centerWidget: Column(
        children: [
          LottieBuilder.asset(
            'assets/lotties/post_lottie.json',
            height: 250.h,
            reverse: true,
            repeat: true,
            frameRate: FrameRate.max,
          ),
          SizedText(
            text: 'Here you can \n Post memes',
            textStyle: latoB25.copyWith(color: ThemeColors.coolgray100),
          )
        ],
      ),
    ));

    slides.add(Slide(
      backgroundColor: ThemeColors.coolgray600,
      centerWidget: Column(
        children: [
          LottieBuilder.asset(
            'assets/lotties/event_lottie.json',
            height: 250.h,
            reverse: true,
            repeat: true,
            frameRate: FrameRate.max,
          ),
          SizedText(
            text: 'Here you can \n Join/Create an event',
            textStyle: latoB25.copyWith(color: ThemeColors.coolgray100),
          )
        ],
      ),
    ));

    slides.add(Slide(
      backgroundColor: ThemeColors.coolgray600,
      centerWidget: Column(
        children: [
          LottieBuilder.asset(
            'assets/lotties/help_lottie.json',
            height: 250.h,
            reverse: true,
            repeat: true,
            frameRate: FrameRate.max,
          ),
          SizedText(
            text: 'Here you can \n Ask for help',
            textStyle: latoB25.copyWith(color: ThemeColors.coolgray100),
          )
        ],
      ),
    ));
  }

  void onDonePress() {
    // Do what you want
    appStore.dispatch(
        NavigateToAction(to: AppRoutes.loginPageRoute, replace: true));
  }

  void onNextPress() {
    print("onNextPress caught");
  }

  Widget renderNextBtn() {
    return const Icon(Icons.navigate_next,
        color: ThemeColors.coolgray100, size: 35.0);
  }

  Widget renderDoneBtn() {
    return const Icon(Icons.done, color: ThemeColors.coolgray100, size: 35.0);
  }

  Widget renderSkipBtn() {
    return const Icon(Icons.skip_next,
        color: ThemeColors.coolgray100, size: 35.0);
  }

  ButtonStyle myButtonStyle() {
    return ButtonStyle(
      shape: MaterialStateProperty.all<OutlinedBorder>(const StadiumBorder()),
      backgroundColor:
          MaterialStateProperty.all<Color>(ThemeColors.coolgray500),
      overlayColor: MaterialStateProperty.all<Color>(ThemeColors.coolgray100),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: IntroSlider(
        // List slides
        slides: slides,

        // Skip button
        renderSkipBtn: renderSkipBtn(),
        skipButtonStyle: myButtonStyle(),

        // Next button
        renderNextBtn: renderNextBtn(),
        onNextPress: onNextPress,
        nextButtonStyle: myButtonStyle(),

        // Done button
        renderDoneBtn: renderDoneBtn(),
        onDonePress: onDonePress,
        doneButtonStyle: myButtonStyle(),

        // Dot indicator
        colorDot: ThemeColors.coolgray700,
        colorActiveDot: ThemeColors.coolgray100,
        sizeDot: 13.0,
      ),
    );
  }

  Future<bool> _onWillPop() {
    final difference = DateTime.now().difference(timeBackPressed);
    final isExitWarning = difference >= const Duration(seconds: 2);

    timeBackPressed = DateTime.now();

    if (isExitWarning) {
      const message = 'Press back again to exit';
      Fluttertoast.showToast(
          msg: message,
          fontSize: 18,
          backgroundColor: ThemeColors.white,
          textColor: ThemeColors.bluegray800);
      return Future.value(false);
    } else {
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      return Future.value(false);
    }
  }
}
