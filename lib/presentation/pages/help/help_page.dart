import 'package:alien_mates/mgr/navigation/app_routes.dart';
import 'package:alien_mates/presentation/widgets/cached_image_or_text_widget.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:alien_mates/mgr/models/model_exporter.dart';
import 'package:alien_mates/mgr/redux/action.dart';
import 'package:alien_mates/presentation/template/base/template.dart';

class HelpPage extends StatefulWidget {
  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) => DefaultBody(
                child: ListView(
              controller: _controller,
              children: [
                SizedBox(height: 10.h),
                DefaultBanner(
                  height: 90.h,
                  onTap: () {},
                  // child: _buildBanners(state),
                ),
                Container(
                    margin: EdgeInsets.symmetric(vertical: 25.h),
                    child: BodyNavigationBar()),
                ..._buildPostsWidgetList(state)
              ],
            )));
  }

  List<Widget> _buildPostsWidgetList(AppState state) {
    OverlayEntry _popupEntry;
    List<Widget> _list = [];
    List<ListPostModelRes> postsList = state.apiState.posts;
    for (int i = 0; i < postsList.length; i++) {
      ListPostModelRes _item = postsList[i];
      if (_item.isHelp) {
        _list.add(
          PostItemBanner(
              imageUrl: _item.imageUrl,
              withBorder: true,
              desc: _item.description,
              height: 160.h,
              bgColor: ThemeColors.black,
              child: GestureDetector(
                onTap: () {
                  _singlePostDetail(_item.postId);
                },
                child: CachedImageOrTextImageWidget(
                    title: _item.title,
                    imageUrl: _item.imageUrl,
                    description: _item.description),
              )),
        );
        _list.add(SizedBox(height: 20.h));
      }
    }
    return _list;
  }

  _singlePostDetail(postId) async {
    await appStore.dispatch(GetPostByIdAction(postId));
    appStore.dispatch(NavigateToAction(to: AppRoutes.helpDetailsPageRoute));
  }
}
