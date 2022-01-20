import 'package:alien_mates/mgr/firebase/firebase_kit.dart';
import 'package:alien_mates/mgr/navigation/app_routes.dart';
import 'package:alien_mates/mgr/redux/action.dart';
import 'package:alien_mates/mgr/redux/app_state.dart';
import 'package:alien_mates/presentation/template/base/template.dart';
import 'package:alien_mates/presentation/widgets/open_image_popup.dart';
import 'package:alien_mates/utils/common/log_tester.dart';

class DefaultBanner extends StatelessWidget {
  Widget? child;
  double? height;
  bool withBottomLeftRadius;
  bool withBottomRightRadius;
  bool withBorder;
  Color bgColor;
  VoidCallback? onTap;

  DefaultBanner({
    this.child,
    this.height,
    this.bgColor = ThemeColors.componentBgDark,
    this.withBottomLeftRadius = true,
    this.withBottomRightRadius = true,
    this.withBorder = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ClipRRect(
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
              color: bgColor,
              borderRadius: BorderRadius.only(
                  bottomLeft: withBottomLeftRadius
                      ? Radius.circular(10.r)
                      : Radius.zero,
                  bottomRight: withBottomRightRadius
                      ? Radius.circular(10.r)
                      : Radius.zero,
                  topLeft: Radius.circular(10.r),
                  topRight: Radius.circular(10.r)),
              border: withBorder
                  ? Border.all(width: 1.w, color: ThemeColors.borderDark)
                  : Border.all(width: 0)),
          height: height,
          width: double.infinity,
        ),
      ),
    );
  }
}

class BodyNavigationBar extends StatelessWidget {
  String currentRoute = appStore.state.navigationState.current!;
  @override
  Widget build(BuildContext context) {
    return DefaultBanner(
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _getNavText(
              currentRoute == AppRoutes.homePageRoute
                  ? ThemeColors.bgLight
                  : ThemeColors.borderDark,
              'Posts', () {
            appStore.dispatch(NavigateToAction(to: AppRoutes.homePageRoute));
          }),
          _getNavText(
              currentRoute == AppRoutes.eventsPageRoute
                  ? ThemeColors.bgLight
                  : ThemeColors.borderDark,
              'Events', () {
            appStore.dispatch(NavigateToAction(to: AppRoutes.eventsPageRoute));
          }),
          _getNavText(
              currentRoute == AppRoutes.helpPageRoute
                  ? ThemeColors.bgLight
                  : ThemeColors.borderDark,
              'Support', () {
            appStore.dispatch(NavigateToAction(to: AppRoutes.helpPageRoute));
          }),
        ],
      ),
    );
  }

  Widget _getNavText(Color textColor, String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: InkWell(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SizedText(
            text: text,
            textStyle: latoB18.copyWith(color: textColor),
          ),
        ),
      ),
    );
  }
}

class PostItemBanner extends StatefulWidget {
  double height;
  Widget? leftWidget;
  Widget? rightWidget;
  Widget child;
  Color bgColor;
  bool withBorder;
  String? imageUrl;
  String? desc;
  VoidCallback? onDoubleTap;
  VoidCallback? onTap;
  PostItemBanner({
    required this.child,
    this.height = 145,
    this.leftWidget,
    this.onDoubleTap,
    this.withBorder = false,
    this.bgColor = ThemeColors.componentBgDark,
    this.imageUrl,
    this.desc,
    this.rightWidget,
    this.onTap,
  });

  @override
  State<PostItemBanner> createState() => _PostItemBannerState();
}

class _PostItemBannerState extends State<PostItemBanner> {
  OverlayEntry? _popupDialog;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onDoubleTap: widget.onDoubleTap,
      onLongPress: widget.imageUrl != null
          ? () {
              _popupDialog = _createPopupDialog(widget.imageUrl!);
              Overlay.of(context)!.insert(_popupDialog!);
            }
          : widget.desc != null
              ? () {
                  _popupDialog = _createPopupDialogForDesc(widget.desc!);
                  Overlay.of(context)!.insert(_popupDialog!);
                }
              : null,
      onLongPressEnd: (details) {
        _popupDialog?.remove();
      },
      child: Column(
        children: [
          DefaultBanner(
              bgColor: widget.bgColor,
              withBorder: widget.withBorder,
              withBottomLeftRadius: widget.leftWidget == null,
              withBottomRightRadius: widget.leftWidget == null,
              child: widget.child,
              height: widget.height),
          if (widget.leftWidget != null || widget.rightWidget != null)
            PostButton(
              leftChild: widget.leftWidget!,
              rightChild: widget.rightWidget,
            ),
        ],
      ),
    );
  }

  OverlayEntry _createPopupDialog(String url, {String? desc}) {
    return OverlayEntry(
      builder: (context) => AnimatedDialog(
        child: createPopupContent(url),
      ),
    );
  }

  OverlayEntry _createPopupDialogForDesc(String desc) {
    return OverlayEntry(
      builder: (context) => AnimatedDialog(
        child: createPopupContentForDesc(desc),
      ),
    );
  }
}
