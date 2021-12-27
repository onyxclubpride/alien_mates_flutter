import 'package:alien_mates/presentation/template/base/template.dart';

class MainButton extends StatelessWidget {
  String text;
  void Function()? onPressed;
  bool? isGray;
  MainButton({required this.text, this.onPressed, this.isGray = false});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: mainButtonTheme().copyWith(
          backgroundColor: isGray!
              ? MaterialStateProperty.all<Color>(
                  (ThemeColors.gray1),
                )
              : mainButtonTheme().backgroundColor),
      onPressed: onPressed,
      child: SizedText(
        text: text,
        textStyle: latoM16.copyWith(
          color: ThemeColors.fontWhite,
        ),
      ),
    );
  }
}
