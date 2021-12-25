import 'package:smart_house_flutter/presentation/template/base/template.dart';

class InputLabel extends StatelessWidget {
  String label;
  InputLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Text(
        AppLocalizations.of(context)!.getString(label).toString(),
        textAlign: TextAlign.start,
        style: latoR14.copyWith(color: Colors.white),
      ),
    );
  }
}
