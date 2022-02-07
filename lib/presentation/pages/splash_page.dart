import 'dart:developer';

import 'package:alien_mates/mgr/redux/middleware/api_middleware.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/scheduler.dart';
import 'package:alien_mates/mgr/redux/action.dart';
import 'package:alien_mates/presentation/template/base/template.dart';
import 'package:lottie/lottie.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback(_load);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultBody(
      showAppBar: false,
      withNavigationBar: false,
      withTopBanner: false,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextLiquidFill(
                textAlign: TextAlign.center,
                text: 'Alien\nMates',
                waveColor: ThemeColors.white,
                boxBackgroundColor: ThemeColors.green800,
                loadDuration: const Duration(seconds: 3),
                textStyle: latoB60.copyWith(color: ThemeColors.bgLight),
                boxWidth: 300.w)
          ],
        ),
      ),
    );
  }

  Future<void> _load(Duration timeStamp) async {
    const _totalSteps = '1';

    log('\nGet State INIT [1/$_totalSteps]');
    appStore.dispatch(GetStateInitAction());
  }
}
