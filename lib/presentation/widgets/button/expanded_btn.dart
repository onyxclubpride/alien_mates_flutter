import 'package:alien_mates/presentation/template/base/template.dart';

class ExpandedButton extends StatelessWidget {
  String text;
  void Function()? onPressed;
  bool? isGray;
  double width;
  ExpandedButton(
      {required this.text,
      this.onPressed,
      this.isGray = false,
      this.width = double.infinity});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width.w,
      child: ElevatedButton(
        style: expandedButtonTheme().copyWith(
            backgroundColor: isGray!
                ? MaterialStateProperty.all<Color>(
                    (ThemeColors.gray1),
                  )
                : expandedButtonTheme().backgroundColor),
        onPressed: onPressed,
        child: SizedText(text: text, textStyle: latoB25),
      ),
    );
  }
}
