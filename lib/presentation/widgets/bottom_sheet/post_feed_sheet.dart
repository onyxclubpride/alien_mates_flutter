import 'package:flutter_redux/flutter_redux.dart';
import 'package:alien_mates/mgr/navigation/app_routes.dart';
import 'package:alien_mates/mgr/redux/action.dart';
import 'package:alien_mates/presentation/template/base/template.dart';

class PostFeed extends StatefulWidget {
  @override
  State<PostFeed> createState() => _PostFeedState();
}

class _PostFeedState extends State<PostFeed> {
  // backgroundColor: Color.fromRGBO(r, g, b, 0)
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) {
          return SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                color: Colors.black,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20.w),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  SpacedColumn(
                    verticalSpace: 21,
                    children: [
                      Container(
                        height: 3,
                        width: 70.w,
                        color: Colors.grey,
                      ),
                      SpacedColumn(verticalSpace: 25, children: [
                        ExpandedButton(
                          text: 'Feed',
                          onPressed: () {},
                        ),
                        ExpandedButton(
                          text: 'Event',
                          onPressed: () {
                            appStore.dispatch(NavigateToAction(
                                to: AppRoutes.createEventPageRoute));
                          },
                        ),
                        ExpandedButton(
                          text: 'Help',
                          onPressed: () {
                            appStore.dispatch(NavigateToAction(
                                to: AppRoutes.createHelpPageRoute));
                          },
                        ),
                        ExpandedButton(
                          text: 'Notice',
                          onPressed: () {
                            print("HELLO WORLD");
                          },
                        ),
                      ]),
                    ],
                  ),
                ]),
              ),
            ),
          );
        });
  }
}
