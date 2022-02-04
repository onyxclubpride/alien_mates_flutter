import 'package:alien_mates/mgr/redux/action.dart';
import 'package:alien_mates/mgr/redux/middleware/api_middleware.dart';
import 'package:alien_mates/presentation/template/base/template.dart';
import 'package:alien_mates/presentation/widgets/cached_image_or_text_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ionicons/ionicons.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

enum PostTypeEnum { POST, EVENT, HELP }

extension StringParsing on PostTypeEnum {
  String parseString() {
    switch (this) {
      case PostTypeEnum.POST:
        return 'isPost';
      case PostTypeEnum.EVENT:
        return 'isEvent';
      case PostTypeEnum.HELP:
        return 'isHelp';
    }
  }
}

class PostLayout extends StatefulWidget {
  PostTypeEnum postType;
  Widget Function(BuildContext ctx, List<DocumentSnapshot<Object?>>, int index,
      AppState state) buildWidget;
  PostLayout({required this.buildWidget, required this.postType});

  @override
  State<PostLayout> createState() => _PostLayoutState();
}

class _PostLayoutState extends State<PostLayout> {
  bool _showBackToTopButton = false;

  ScrollController _controller = ScrollController();

  @override
  void initState() {
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
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) => Scaffold(
              floatingActionButton: _showBackToTopButton
                  ? FloatingActionButton(
                      backgroundColor: ThemeColors.bluegray700,
                      onPressed: _scrollToTop,
                      child: const Icon(Ionicons.arrow_up_outline),
                    )
                  : null,
              appBar: _getHeader(),
              body: PaginateFirestore(
                onEmpty: _getEmptyWidgets(),
                separator: SizedBox(height: 20.h),
                scrollController: _controller,
                itemBuilder: (_, documentSnapshots, index) {
                  return Column(
                    children: [
                      if (index == 0)
                        Column(
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
                                        .apiState.bannerPosts[index].imageUrl,
                                    description: state.apiState
                                        .bannerPosts[index].description),
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
                          ],
                        ),
                      widget.buildWidget(_, documentSnapshots, index, state),
                    ],
                  );
                },
                physics: const BouncingScrollPhysics(),
                query: _getQuery(state),
                itemBuilderType: PaginateBuilderType.listView,
                isLive: true,
                padding: EdgeInsets.symmetric(horizontal: 12.w),
              ),
            ));
  }

  _getQuery(AppState state) {
    return postsCollection
        .orderBy('createdDate', descending: true)
        .where(widget.postType.parseString(), isEqualTo: true)
        .limit(10);
  }

  _getHeader() {
    return DefaultHeader(
      withAction: true,
      titleText: null,
    );
  }

  // This function is triggered when the user presses the back-to-top button
  void _scrollToTop() {
    _controller.animateTo(0,
        duration: const Duration(milliseconds: 300), curve: Curves.linear);
  }

  Widget _getEmptyWidgets() {
    return Column(
      children: [Text('Empty Page Edit here')],
    );
  }
}
