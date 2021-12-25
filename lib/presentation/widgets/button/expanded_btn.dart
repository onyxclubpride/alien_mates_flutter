import 'package:alien_mates/presentation/template/base/template.dart';

class ExpandedButton extends StatelessWidget {
  String text;
  void Function()? onPressed;
  bool? isGray;
  ExpandedButton({required this.text, this.onPressed, this.isGray = false});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: expandedButtonTheme().copyWith(
          backgroundColor: isGray!
              ? MaterialStateProperty.all<Color>(
                  (ThemeColors.gray1),
                )
              : expandedButtonTheme().backgroundColor),
      onPressed: onPressed,
      child: SizedText(
          text: text,
          textStyle: latoB25.copyWith(color: ThemeColors.fontLight)),
    );
  }
}
