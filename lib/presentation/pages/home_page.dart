import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:smart_house_flutter/mgr/firebase/firebase_kit.dart';
import 'package:smart_house_flutter/mgr/models/model_exporter.dart';
import 'package:smart_house_flutter/mgr/redux/action.dart';
import 'package:smart_house_flutter/mgr/redux/app_state.dart';
import 'package:smart_house_flutter/presentation/template/base/template.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: appStore,
      child: StoreConnector<AppState, AppState>(
          converter: (store) => store.state,
          builder: (context, state) => DefaultBody(
                  child: ListView(
                controller: _controller,
                children: [
                  DefaultBanner(
                      child: InkWell(
                    onTap: () {
                      print(_controller.position);
                    },
                    child: Container(),
                  )),
                  SizedBox(height: 40.h),
                  BodyNavigationBar(),
                  SizedBox(height: 25.h),
                  ..._buildPostsWidgetList(state)
                ],
              ))),
    );
  }

  List<Widget> _buildPostsWidgetList(AppState state) {
    List<Widget> _list = [];
    List<ListPostModelRes> postsList = state.apiState.posts;

    for (int i = 0; i < postsList.length; i++) {
      _list.add(PostItemBanner(
          child: CachedNetworkImage(
        imageUrl: state.apiState.posts[i].imageUrl!,
        fit: BoxFit.cover,
      )));
    }
    return _list;
  }
}
