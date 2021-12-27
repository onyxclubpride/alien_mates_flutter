import 'package:alien_mates/mgr/navigation/app_routes.dart';
import 'package:alien_mates/mgr/redux/action.dart';
import 'package:alien_mates/presentation/template/base/template.dart';
import 'package:alien_mates/presentation/widgets/input/post_create_input.dart';
import 'package:alien_mates/utils/common/global_widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';

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
  bool withActionButton;
  SizedText? titleText;

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
    this.titleText,
    this.withActionButton = true,
    this.withNavigationBar = true,
    this.withTopBanner = true,
  });

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) => Scaffold(
              resizeToAvoidBottomInset: true,
              appBar: showAppBar
                  ? DefaultHeader(
                      withAction: withActionButton,
                      titleText: titleText,
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
                          if (withTopBanner)
                            DefaultBanner(
                              height: 90.h,
                              onTap: () {
                                _onBannerTap();
                              },
                              // child: _buildBanners(state),
                            ),
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
                                  MediaQuery.of(context).padding.top -
                                  MediaQuery.of(context).padding.bottom,
                              child: child),
                        ],
                      )
                    : child,
              )),
            ));
  }

  Widget _buildBanners(AppState state) {
    return Image.network(state.apiState.posts.first.imageUrl!,
        fit: BoxFit.fill);
  }

  _onBannerTap() {
    // appStore.dispatch(NavigateToAction(to: AppRoutes.createEventPageRoute));
  }
}
