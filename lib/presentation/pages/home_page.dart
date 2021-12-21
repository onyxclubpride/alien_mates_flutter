import 'package:flutter/material.dart';
import 'package:smart_house_flutter/presentation/template/base/template.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultBody(child: Column(
      children: [
        DefaultBanner(child: Container(
          color: Colors.red,
        ),)
        ],
        )
      );
  }
}
