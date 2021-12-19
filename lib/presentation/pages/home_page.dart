import 'package:flutter/material.dart';
import 'package:smart_house_flutter/presentation/layout/default_body.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultBody(child: const Text('Home page'));
  }
}
