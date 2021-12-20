import 'package:smart_house_flutter/presentation/template/base/template.dart';

class DefaultBanner extends StatelessWidget {
  const DefaultBanner({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(10.0),
        color: Colors.amber[600],
        width: 48.w,
        height: 48.h,
      ),
    );
  }
}
