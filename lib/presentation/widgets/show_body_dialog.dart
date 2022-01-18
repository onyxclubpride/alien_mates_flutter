import 'package:alien_mates/mgr/redux/action.dart';
import 'package:alien_mates/presentation/template/base/template.dart';
import 'package:alien_mates/presentation/widgets/button/expanded_btn.dart';
import 'package:alien_mates/presentation/widgets/button/normal_button.dart';

Future showBodyDialog(
  BuildContext context, {
  void Function()? onPress,
  String? text,
  String onMainButtonText = "OnDo",
  bool barrierDismissible = true,
  Color? color = ThemeColors.fontWhite,
}) {
  return showDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (context) {
      return SimpleDialog(
        backgroundColor: color,
        title: Column(
          children: [
            text != null ? Text(text, style: latoB18) : const SizedBox(),
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.all(20.w),
              child: SpacedRow(
                mainAxisAlignment: MainAxisAlignment.center,
                horizontalSpace: 15.w,
                children: [
                  NormalButton(
                    text: 'Cancel',
                    isGray: true,
                    onPressed: () {
                      appStore.dispatch(DismissPopupAction());
                    },
                  ),
                  NormalButton(
                      text: onMainButtonText, isGray: true, onPressed: onPress),
                ],
              ),
            )
          ],
        ),
        contentPadding: EdgeInsets.zero,
        titlePadding:
            text != null ? EdgeInsets.only(top: 50.h) : EdgeInsets.zero,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        elevation: 0,
      );
    },
  );
}
