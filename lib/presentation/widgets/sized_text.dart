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
  final bool isSelectable;
  const SizedText({
    this.width,
    this.height,
    this.text,
    this.textStyle,
    this.useLocaleText = true,
    this.overflow = TextOverflow.visible,
    this.textAlign = TextAlign.center,
    this.maxLines,
    this.isSelectable = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: !isSelectable
          ? Text(
              useLocaleText
                  ? AppLocalizations.of(context)!.getString(text)!
                  : text!,
              style: textStyle,
              textAlign: textAlign,
              maxLines: maxLines,
              overflow: overflow,
            )
          : SelectableText(
              useLocaleText
                  ? AppLocalizations.of(context)!.getString(text)!
                  : text!,
              style: textStyle,
              textAlign: textAlign,
              maxLines: maxLines,
            ),
    );
  }
}
