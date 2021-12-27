import 'package:alien_mates/presentation/template/base/template.dart';

// still need to work on it

bottomSheet(BuildContext context,
    {void Function()? onPress,
    required String text,
    String? buttonText,
    double? horizontalPadding = 0.0,
    double? verticalPadding = 0.0,
    double? horizontalMargin = 0.0,
    double? verticalMargin = 0.0,
    bool barrierDismissible = true,
    Color? backgroundColor = Colors.transparent,
    bool? isScrollControlled = true,
    AnimationController? transitionAnimationController,
    bool? enableDrag = true}) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [],
      );
    },
  );
}
