import 'package:alien_mates/presentation/widgets/button/expanded_btn.dart';
import 'package:alien_mates/presentation/widgets/input/basic_input.dart';
import 'package:alien_mates/presentation/widgets/show_alert_dialog.dart';
import 'package:alien_mates/utils/common/validators.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ionicons/ionicons.dart';
import 'package:alien_mates/mgr/models/model_exporter.dart';
import 'package:alien_mates/mgr/navigation/app_routes.dart';
import 'package:alien_mates/mgr/redux/action.dart';
import 'package:alien_mates/mgr/redux/app_state.dart';
import 'package:alien_mates/mgr/redux/states/api_state.dart';
import 'package:alien_mates/presentation/template/base/template.dart';
import 'package:alien_mates/utils/common/log_tester.dart';

class EventDetailsPage extends StatefulWidget {
  @override
  State<EventDetailsPage> createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  @override
  Widget build(BuildContext context) {
    print("IN Event DETAIL PAGE");
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) {
          var postDetail = state.apiState.postDetail;
          print(postDetail);
          return DefaultBody(
            withTopBanner: false,
            withNavigationBar: false,
            withActionButton: false,
            titleIcon: _buildTitleIcon(state),
            titleText: SizedText(text: 'Back', textStyle: latoM20),
            child: SingleChildScrollView(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                SpacedColumn(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  verticalSpace: 21,
                  children: [
                    if (state.apiState.postDetail.imageUrl != null)
                      PostItemBanner(
                          child: CachedNetworkImage(
                        imageUrl: state.apiState.postDetail.imageUrl!,
                        fit: BoxFit.cover,
                      )),
                    SpacedColumn(verticalSpace: 25, children: [
                      Container(
                          height: MediaQuery.of(context).size.height / 2,
                          alignment: Alignment.topLeft,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedText(
                                    text: state.apiState.postDetail.title,
                                    textStyle:
                                        latoB45.copyWith(color: Colors.white)),
                                SizedBox(height: 20.h),
                                SizedText(
                                  text: state.apiState.postDetail.description,
                                  textStyle:
                                      latoR16.copyWith(color: Colors.white),
                                  textAlign: TextAlign.left,
                                ),
                                SizedBox(height: 20.h),
                                Column(children: [
                                  SpacedRow(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedText(
                                        text: 'Phone Number\t:\t',
                                        textStyle: latoB20.copyWith(
                                            color: ThemeColors.fontWhite),
                                      ),
                                      SizedText(
                                        text: state.apiState.postDetailUser
                                            .phoneNumber,
                                        textStyle: latoM16.copyWith(
                                            color: ThemeColors.fontWhite),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 20.h),
                                  SpacedRow(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedText(
                                        text: 'Location\t:\t',
                                        textStyle: latoB20.copyWith(
                                            color: ThemeColors.fontWhite),
                                      ),
                                      SizedText(
                                        text: state
                                            .apiState.postDetail.eventLocation,
                                        textStyle: latoM16.copyWith(
                                            color: ThemeColors.fontWhite),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 30.h),
                                  Container(
                                    width: MediaQuery.of(context).size.width -
                                        100.w,
                                    padding: EdgeInsets.all(10.w),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(12.r),
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
                                        Text(
                                          state.apiState.postDetail.joinLimit
                                              .toString(),
                                          style: const TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold,
                                              color: ThemeColors.fontWhite),
                                        ),
                                        const Text(
                                          '|',
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
                                                    color: ThemeColors.yellow),
                                              )
                                            : const Text(
                                                '0',
                                                style: TextStyle(
                                                    fontSize: 30,
                                                    fontWeight: FontWeight.bold,
                                                    color: ThemeColors.yellow),
                                              )
                                      ],
                                    ),
                                  ),
                                ]),
                                SizedBox(height: 25.h)
                              ],
                            ),
                          )),
                    ]),
                  ],
                ),
              ]),
            ),
            footer: Container(
              margin: EdgeInsets.only(bottom: 15.h),
              child: ExpandedButton(
                text: (postDetail.joinedUserIds!
                            .contains(state.apiState.userMe.userId) ==
                        true)
                    ? 'UNDO'
                    : 'JOIN',
                onPressed: () {
                  //Change to update
                  postDetail.joinedUserIds!.contains(postDetail.joinedUserIds!
                          .contains(state.apiState.userMe.userId))
                      ? _onUnJoinTap(
                          postDetail.postId,
                          postDetail.joinedUserIds!,
                          postDetail.joinLimit!,
                          postDetail.joinedUserIds!
                              .contains(state.apiState.userMe.userId))
                      : _onJoinTap(
                          postDetail.postId,
                          postDetail.joinedUserIds!,
                          postDetail.joinLimit!,
                          postDetail.joinedUserIds!
                              .contains(state.apiState.userMe.userId));
                },
              ),
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
//  if(state.apiState.postDetail.joinedUserIds.contains(state.apiState.userMe.userId) )