import 'package:alien_mates/presentation/template/base/template.dart';
import 'package:lottie/lottie.dart';

Future showLoadingDialog(BuildContext context,
    {bool? barrierDismissible = false}) {
  return showDialog(
    barrierDismissible: barrierDismissible!,
    context: context,
    builder: (context) {
      return Center(
        child: LottieBuilder.asset('assets/lotties/loading_lottie.json'),
      );
    },
  );
}
