import 'package:alien_mates/presentation/template/base/template.dart';

class NormalButton extends StatelessWidget {
  String text;
  void Function()? onPressed;
  bool? isGray;
  NormalButton({required this.text, this.onPressed, this.isGray = false});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: normalButtonTheme().copyWith(
          backgroundColor: isGray!
              ? MaterialStateProperty.all<Color>(
                  (ThemeColors.gray1),
                )
              : normalButtonTheme().backgroundColor),
      onPressed: onPressed,
      child: SizedText(
        text: text,
      ),
    );
  }
}
