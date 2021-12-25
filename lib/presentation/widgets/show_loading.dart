import 'package:smart_house_flutter/presentation/template/base/template.dart';

Future showLoadingDialog(BuildContext context,
    {bool? barrierDismissible = false}) {
  return showDialog(
    barrierDismissible: barrierDismissible!,
    context: context,
    builder: (context) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    },
  );
}
