import 'package:alien_mates/presentation/template/base/template.dart';

class SizedText extends StatelessWidget {
  final double? width;
  final double? height;
  final String? text;
  final TextStyle? textStyle;
  final bool useLocaleText;
  final TextOverflow overflow;
  final TextAlign textAlign;
  final int? maxLines;

  const SizedText({
    this.width,
    this.height,
    this.text,
    this.textStyle,
    this.useLocaleText = true,
    this.overflow = TextOverflow.visible,
    this.textAlign = TextAlign.center,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Text(
        useLocaleText ? AppLocalizations.of(context)!.getString(text)! : text!,
        style: textStyle,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
      ),
    );
  }
}
