import 'package:smart_house_flutter/mgr/firebase/firebase_kit.dart';
import 'package:smart_house_flutter/mgr/redux/action.dart';
import 'package:smart_house_flutter/mgr/redux/app_state.dart';
import 'package:smart_house_flutter/presentation/template/base/template.dart';

class DefaultBanner extends StatelessWidget {
  Widget? child;
  double height;
  bool withBottomLeftRadius;
  bool withBottomRightRadius;
  bool withBorder;
  DefaultBanner(
      {this.child,
      this.height = 90,
      this.withBottomLeftRadius = true,
      this.withBottomRightRadius = true,
      this.withBorder = true});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          bottomLeft:
              withBottomLeftRadius ? Radius.circular(10.r) : Radius.zero,
          bottomRight:
              withBottomRightRadius ? Radius.circular(10.r) : Radius.zero,
          topLeft: Radius.circular(10.r),
          topRight: Radius.circular(10.r)),
      child: Container(
        child: child,
        decoration: BoxDecoration(
            color: ThemeColors.componentBgDark,
            border: withBorder
                ? Border.all(color: ThemeColors.borderDark)
                : Border.all(width: 0)),
        height: height.h,
        width: double.infinity,
      ),
    );
  }
}

class BodyNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultBanner(
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _getNavText(ThemeColors.bgLight, 'Posts', () {
            print('onPostsTap');
          }),
          _getNavText(ThemeColors.borderDark, 'Events', () {
            print('onEventsTap');
          }),
          _getNavText(ThemeColors.borderDark, 'Help', () {
            print('onHelpTap');
          }),
        ],
      ),
    );
  }

  Widget _getNavText(Color textColor, String text, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: SizedText(
        text: text,
        textStyle: latoM16.copyWith(color: textColor),
      ),
    );
  }
}

class PostItemBanner extends StatelessWidget {
  double height;
  Widget? leftWidget;
  Widget? rightWidget;
  Widget child;
  PostItemBanner(
      {required this.child,
      this.height = 145,
      this.leftWidget,
      this.rightWidget});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DefaultBanner(
            withBorder: false,
            withBottomLeftRadius: leftWidget == null,
            withBottomRightRadius: leftWidget == null,
            child: child,
            height: 145),
        if (leftWidget != null || rightWidget != null)
          PostButton(
            leftChild: leftWidget!,
            rightChild: rightWidget,
          ),
      ],
    );
  }
}
