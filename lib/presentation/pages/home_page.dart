import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:smart_house_flutter/mgr/firebase/firebase_kit.dart';
import 'package:smart_house_flutter/presentation/template/base/template.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback(_load);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultBody(
        child: Column(
      children: [
        DefaultBanner(child: Container()),
        SizedBox(height: 40.h),
        BodyNavigationBar(),
        SizedBox(height: 25.h),
        PostItemBanner(),
      ],
    ));
  }

  Future<void> _load(Duration timeStamp) async {}
}
