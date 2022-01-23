import 'package:alien_mates/mgr/navigation/app_routes.dart';
import 'package:alien_mates/mgr/redux/action.dart';
import 'package:alien_mates/presentation/template/base/template.dart';
import 'package:alien_mates/presentation/widgets/cached_image_or_text_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ionicons/ionicons.dart';

class DefaultBody extends StatefulWidget {
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
  Widget? footer;
  Widget? floatingAction;
  VoidCallback? onRefresh;

  DefaultBody(
      {this.centerTitle = false,
      this.showAppBar = true,
      this.titleIcon,
      this.footer,
      this.leftButton,
      required this.child,
      this.onRightButtonClick,
      this.bottomPadding = 0,
      this.horizontalPadding = 12,
      this.topPadding = 0,
      this.rightIcon,
      this.titleText,
      this.withActionButton = true,
      this.withNavigationBar = true,
      this.withTopBanner = true,
      this.floatingAction,
      this.onRefresh});

  @override
  State<DefaultBody> createState() => _DefaultBodyState();
}

class _DefaultBodyState extends State<DefaultBody> {
  bool _showBackToTopButton = false;

  bool? showFloatingButton;
  ScrollController _controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = ScrollController()
      ..addListener(() {
        setState(() {
          if (_controller.offset >= 400) {
            _showBackToTopButton = true; // show the back-to-top button
          } else {
            _showBackToTopButton = false; // hide the back-to-top button
          }
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose(); // dispose the controller
    super.dispose();
  }

  // This function is triggered when the user presses the back-to-top button
  void _scrollToTop() {
    _controller.animateTo(0,
        duration: const Duration(milliseconds: 300), curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {
    final bool showFab = MediaQuery.of(context).viewInsets.bottom == 0.0;
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) => Scaffold(
              resizeToAvoidBottomInset: true,
              floatingActionButton: widget.floatingAction != null
                  ? widget.floatingAction
                  : _showBackToTopButton == false
                      ? null
                      : FloatingActionButton(
                          backgroundColor: ThemeColors.bluegray700,
                          onPressed: _scrollToTop,
                          child: Icon(Icons.arrow_upward),
                        ),
              appBar: widget.showAppBar
                  ? DefaultHeader(
                      withAction: widget.withActionButton,
                      titleText: widget.titleText,
                      centerTitle: widget.centerTitle,
                      leftButton: widget.leftButton,
                      titleIcon: widget.titleIcon,
                      onRightButtonClick: widget.onRightButtonClick,
                      rightIcon: widget.rightIcon,
                    )
                  : null,
              bottomSheet: widget.footer != null
                  ? showFab
                      ? Padding(
                          padding: EdgeInsets.only(
                            left: widget.horizontalPadding!.w,
                            right: widget.horizontalPadding!.w,
                            bottom: widget.bottomPadding!.h,
                          ),
                          child: widget.footer)
                      : null
                  : null,
              body: SafeArea(
                  child: Padding(
                padding: EdgeInsets.only(
                  left: widget.horizontalPadding!.w,
                  right: widget.horizontalPadding!.w,
                  bottom: widget.bottomPadding!.h,
                  top: widget.topPadding!.h,
                ),
                child: widget.withTopBanner || widget.withNavigationBar
                    ? RefreshIndicator(
                        color: ThemeColors.yellow,
                        backgroundColor: ThemeColors.coolgray300,
                        edgeOffset: 8,
                        onRefresh: () {
                          return Future.delayed(
                              const Duration(seconds: 1), widget.onRefresh);
                        },
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height -
                              70.h -
                              MediaQuery.of(context).padding.bottom,
                          child: ListView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            controller: _controller,
                            children: [
                              CarouselSlider.builder(
                                itemCount: state.apiState.bannerPosts.length,
                                options: CarouselOptions(
                                    onPageChanged: (index, reason) {
                                      appStore.dispatch(UpdateApiStateAction(
                                          bannerIndex: index));
                                    },
                                    enableInfiniteScroll: false,
                                    viewportFraction: 1,
                                    height: 90.h),
                                itemBuilder: (context, index, realIndex) =>
                                    PostItemBanner(
                                  height: 90.h,
                                  child: CachedImageOrTextImageWidget(
                                      imageUrl: state
                                          .apiState
                                          .bannerPosts[
                                              state.apiState.bannerIndex]
                                          .imageUrl,
                                      description: state
                                          .apiState
                                          .bannerPosts[
                                              state.apiState.bannerIndex]
                                          .description),
                                ),
                              ),
                              SizedBox(height: 5.h),
                              SpacedRow(
                                  horizontalSpace: 5,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      state.apiState.bannerIndex == 0
                                          ? Ionicons.stop_circle_outline
                                          : Ionicons.ellipse_outline,
                                      color: Colors.white,
                                      size: 10.h,
                                    ),
                                    Icon(
                                      state.apiState.bannerIndex == 1
                                          ? Ionicons.stop_circle_outline
                                          : Ionicons.ellipse_outline,
                                      color: Colors.white,
                                      size: 10.h,
                                    ),
                                    Icon(
                                      state.apiState.bannerIndex == 2
                                          ? Ionicons.stop_circle_outline
                                          : Ionicons.ellipse_outline,
                                      color: Colors.white,
                                      size: 10.h,
                                    ),
                                  ]),
                              Container(
                                  margin: EdgeInsets.symmetric(vertical: 15.h),
                                  child: BodyNavigationBar()),
                              widget.child
                            ],
                          ),
                        ),
                      )
                    : widget.child,
              )),
            ));
  }
}
