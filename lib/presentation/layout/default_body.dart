import 'package:smart_house_flutter/presentation/template/base/template.dart';

class DefaultBody extends StatelessWidget {
  Widget child;
  bool? centerTitle;
  Widget? titleIcon;
  Widget? leftButton;

  DefaultBody(
      {this.centerTitle = false,
      this.titleIcon,
      this.leftButton,
      required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultHeader(),
      body: SafeArea(child: child),
    );
  }
}
