import 'package:alien_mates/presentation/template/base/template.dart';

class DefaultBody extends StatelessWidget {
  Widget child;
  bool? centerTitle;
  Widget? titleIcon;
  Widget? leftButton;
  IconData? rightIcon;
  VoidCallback? onRightButtonClick;
  double? horizontalPadding;
  double? bottomPadding;
  double? topPadding;
  bool showAppBar;
  bool withTopBanner;
  bool withNavigationBar;

  DefaultBody({
    this.centerTitle = false,
    this.showAppBar = true,
    this.titleIcon,
    this.leftButton,
    required this.child,
    this.onRightButtonClick,
    this.bottomPadding = 0,
    this.horizontalPadding = 20,
    this.topPadding = 0,
    this.rightIcon,
    this.withNavigationBar = true,
    this.withTopBanner = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: showAppBar
          ? DefaultHeader(
              centerTitle: centerTitle,
              leftButton: leftButton,
              titleIcon: titleIcon,
              onRightButtonClick: onRightButtonClick,
              rightIcon: rightIcon,
            )
          : null,
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.only(
          left: horizontalPadding!.w,
          right: horizontalPadding!.w,
          bottom: bottomPadding!.h,
          top: topPadding!.h,
        ),
        child: withTopBanner || withNavigationBar
            ? Column(
                children: [
                  if (withTopBanner) DefaultBanner(),
                  if (withNavigationBar)
                    Container(
                        margin: EdgeInsets.symmetric(vertical: 25.h),
                        child: BodyNavigationBar()),
                  SizedBox(
                      height: MediaQuery.of(context).size.height -
                          30.h -
                          50.h -
                          70.h -
                          90.h -
                          MediaQuery.of(context).padding.top,
                      child: child),
                ],
              )
            : child,
      )),
    );
  }
}
