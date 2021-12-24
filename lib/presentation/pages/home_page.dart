import 'package:flutter/material.dart';
import 'package:smart_house_flutter/presentation/template/base/template.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

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
}
