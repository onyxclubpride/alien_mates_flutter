import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ionicons/ionicons.dart';
import 'package:alien_mates/mgr/redux/action.dart';
import 'package:alien_mates/presentation/template/base/template.dart';

class EventDetailsPage extends StatefulWidget {
  @override
  State<EventDetailsPage> createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) {
          var postDetail = state.apiState.postDetail;
          String _userId = state.apiState.userMe.userId;

          return DefaultBody(
            withTopBanner: false,
            withNavigationBar: false,
            withActionButton: false,
            titleIcon: _buildTitleIcon(state),
            titleText: SizedText(text: 'Back', textStyle: latoM20),
            child: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 50.h),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                SpacedColumn(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  verticalSpace: 21,
                  children: [
                    if (state.apiState.postDetail.imageUrl != null)
                      PostItemBanner(
                          height: 200.h,
                          imageUrl: state.apiState.postDetail.imageUrl,
                          child: CachedNetworkImage(
                            imageUrl: state.apiState.postDetail.imageUrl!,
                            fit: BoxFit.cover,
                          )),
                    SpacedColumn(verticalSpace: 25, children: [
                      Column(
                        children: [
                          SizedText(
                              textAlign: TextAlign.start,
                              text: state.apiState.postDetail.title,
                              textStyle: latoB25.copyWith(color: Colors.white)),
                          SizedBox(height: 20.h),
                          SizedText(
                            text: state.apiState.postDetail.description,
                            textStyle: latoR16.copyWith(color: Colors.white),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(height: 20.h),
                          Column(children: [
                            SpacedRow(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedText(
                                  text: 'Phone Number\t:\t',
                                  textStyle: latoB20.copyWith(
                                      color: ThemeColors.fontWhite),
                                ),
                                SizedText(
                                  isSelectable: true,
                                  text:
                                      state.apiState.postDetailUser.phoneNumber,
                                  textStyle: latoM16.copyWith(
                                      color: ThemeColors.fontWhite),
                                )
                              ],
                            ),
                            SizedBox(height: 20.h),
                            SpacedRow(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedText(
                                  text: 'Location\t:\t',
                                  textStyle: latoB20.copyWith(
                                      color: ThemeColors.fontWhite),
                                ),
                                SizedText(
                                  isSelectable: true,
                                  text: state.apiState.postDetail.eventLocation,
                                  textStyle: latoM16.copyWith(
                                      color: ThemeColors.fontWhite),
                                )
                              ],
                            ),
                            SizedBox(height: 30.h),
                            Container(
                              width: MediaQuery.of(context).size.width - 100.w,
                              padding: EdgeInsets.all(10.w),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.r),
                                  color: ThemeColors.borderDark),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Text(
                                    'Max : ',
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        color: ThemeColors.fontWhite),
                                  ),
                                  (postDetail.joinedUserIds!.isNotEmpty)
                                      ? Text(
                                          postDetail.joinedUserIds!.length
                                              .toString(),
                                          style: const TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      : const Text(
                                          '0',
                                          style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                  const Text(
                                    '|',
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        color: ThemeColors.fontWhite),
                                  ),
                                  Text(
                                    state.apiState.postDetail.joinLimit
                                        .toString(),
                                    style: const TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        color: ThemeColors.fontWhite),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                          SizedBox(height: 25.h)
                        ],
                      ),
                    ]),
                  ],
                ),
              ]),
            ),
            bottomPadding: 15,
            footer: ExpandedButton(
              text: (postDetail.joinedUserIds!.contains(_userId) == true)
                  ? 'UNDO'
                  : 'JOIN',
              onPressed: () {
                //Change to update
                postDetail.joinedUserIds!.contains(_userId)
                    ? _onUnJoinTap(postDetail.postId, postDetail.joinedUserIds!,
                        postDetail.joinLimit!, state.initState.userId)
                    : _onJoinTap(
                        postDetail.postId,
                        postDetail.joinedUserIds!,
                        postDetail.joinLimit!,
                        state.initState.userId,
                      );
              },
            ),
          );
        });
  }

  Widget _buildTitleIcon(state) {
    return IconButton(
      padding: EdgeInsets.zero,
      iconSize: 25.w,
      icon: const Icon(Ionicons.chevron_back_outline),
      onPressed: () {
        appStore.dispatch(NavigateToAction(to: 'up'));
      },
    );
  }

  _onJoinTap(String postId, List userIds, int joinLimit, userId) {
    if (joinLimit > userIds.length) {
      if (!userIds.contains(userId)) {
        appStore.dispatch(GetUpdatePostAction(
            postId: postId, joinedUserIds: [...userIds, userId]));
      } else {
        showAlertDialog(context, text: "You have already joined!");
      }
    } else {
      showAlertDialog(context, text: "Guests limit is full!");
    }
  }

  _onUnJoinTap(String postId, List userIds, int joinLimit, userId) {
    List _list = userIds;
    _list.remove(userId);
    appStore
        .dispatch(GetUpdatePostAction(postId: postId, joinedUserIds: _list));
  }
}
