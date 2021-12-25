import 'package:alien_mates/presentation/template/base/template.dart';

class InputLabel extends StatelessWidget {
  String label;
  InputLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: Text(
        AppLocalizations.of(context)!.getString(label).toString(),
        textAlign: TextAlign.start,
        style: latoM12.copyWith(color: ThemeColors.fontWhite),
      ),
    );
  }
}
