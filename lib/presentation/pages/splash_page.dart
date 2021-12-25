import 'dart:developer';

import 'package:flutter/scheduler.dart';
import 'package:smart_house_flutter/mgr/redux/action.dart';
import 'package:smart_house_flutter/presentation/template/base/template.dart';

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
        child: SizedText(
            text: 'Splash Screen is Fetching Data',
            textStyle: latoB45.copyWith(color: ThemeColors.bgLight)),
      ),
    );
  }

  Future<void> _load(Duration timeStamp) async {
    const _totalSteps = '1';

    log('\nGet State INIT [1/$_totalSteps]');
    appStore.dispatch(GetStateInitAction());
  }
}
