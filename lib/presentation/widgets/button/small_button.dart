
import 'package:alien_mates/presentation/template/base/template.dart';

class SmallButton extends StatelessWidget {
  String text;
  void Function()? onPressed;
  bool? isGray;
  Color buttonBgColor;
  SmallButton(
      {required this.text,
      this.onPressed,
      this.isGray = false,
      required this.buttonBgColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: smallButtonTheme().copyWith(
          backgroundColor: isGray!
              ? MaterialStateProperty.all<Color>(
                  (ThemeColors.gray1),
                )
              : MaterialStateProperty.all<Color>(
                  (buttonBgColor),
                )),
      onPressed: onPressed,
      child: SizedText(
        text: text,
        textStyle: latoM12.copyWith(
          color: ThemeColors.fontWhite,
        ),
      ),
    );
  }
}
