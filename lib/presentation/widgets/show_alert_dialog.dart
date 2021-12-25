import 'package:alien_mates/mgr/redux/action.dart';
import 'package:alien_mates/presentation/template/base/template.dart';
import 'package:alien_mates/presentation/widgets/button/expanded_btn.dart';
import 'package:alien_mates/presentation/widgets/popup_layout.dart';

showAlertDialog(BuildContext context,
    {void Function()? onPress,
    required String text,
    String? buttonText,
    double? horizontalPadding = 0.0,
    bool barrierDismissible = true}) {
  return showDialog(
    context: context,
    routeSettings: const RouteSettings(name: 'Alert Dialog'),
    barrierDismissible: barrierDismissible,
    builder: (context) {
      return PopupLayout(
        horizontalPadding: horizontalPadding,
        children: [
          ExpandedButton(
            text: buttonText ?? "Ok",
            onPressed: () {
              if (onPress != null) {
                onPress();
              } else {
                appStore.dispatch(DismissPopupAction());
              }
            },
          ),
        ],
        title: Text(
          text,
          maxLines: 3,
          textAlign: TextAlign.center,
        ),
      );
    },
  );
}
