import 'package:smart_house_flutter/presentation/template/base/template.dart';

class DefaultBody extends StatelessWidget {
  Widget child;
  DefaultBody({required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultHeader(),
      body: SafeArea(child: child),
    );
  }
}
