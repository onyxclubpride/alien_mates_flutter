import 'package:alien_mates/presentation/template/base/template.dart';

class PopupLayout extends StatelessWidget {
  List<Widget> children;
  Widget title;
  double? horizontalPadding;
  PopupLayout(
      {required this.children,
      required this.title,
      this.horizontalPadding = 0.0});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding:
          EdgeInsets.only(bottom: 30.h, left: 30.w, right: 30.w, top: 75.h),
      titlePadding: EdgeInsets.only(
          top: 75.h, left: horizontalPadding!.w, right: horizontalPadding!.w),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      elevation: 0,
      children: children,
      insetPadding: EdgeInsets.symmetric(horizontal: 25.w),
      title: title,
    );
  }
}
