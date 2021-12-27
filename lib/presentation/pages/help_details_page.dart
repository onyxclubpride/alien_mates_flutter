import 'package:alien_mates/presentation/widgets/button/expanded_btn.dart';
import 'package:alien_mates/presentation/widgets/input/basic_input.dart';
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

class HelpDetailsPage extends StatefulWidget {
  @override
  State<HelpDetailsPage> createState() => _HelpDetailsPageState();
}

class _HelpDetailsPageState extends State<HelpDetailsPage> {
  @override
  Widget build(BuildContext context) {
    print("IN HELP DETAIL PAGE");
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) {
          return DefaultBody(
            withTopBanner: false,
            withNavigationBar: false,
            withActionButton: false,
            titleIcon: _buildTitleIcon(),
            titleText: SizedText(text: 'Help Detail', textStyle: latoM20),
            child: SingleChildScrollView(
              child: Container(
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  SpacedColumn(
                    verticalSpace: 21,
                    children: [
                      PostItemBanner(
                          child: CachedNetworkImage(
                        imageUrl: "https://picsum.photos/id/237/500/300",
                        fit: BoxFit.cover,
                      )),
                      SpacedColumn(verticalSpace: 25, children: [
                        Container(
                            alignment: Alignment.topLeft,
                            height: 300.h,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  SizedText(
                                      text: 'The title',
                                      textStyle: latoB45.copyWith(
                                          color: Colors.white)),
                                  SizedBox(height: 20.h),
                                  SizedText(
                                    text: 'The title',
                                    textStyle:
                                        latoR16.copyWith(color: Colors.white),
                                    textAlign: TextAlign.left,
                                  ),
                                  SizedBox(height: 20.h),
                                  Row(
                                    children: [
                                      SizedText(
                                          text: 'Kakao ID : ',
                                          textStyle: latoB14.copyWith(
                                              color: Colors.white)),
                                      SizedBox(width: 20.w),
                                      SizedText(
                                          text: 'NishatNN',
                                          textStyle: latoR16.copyWith(
                                              color: Colors.white)),
                                    ],
                                  ),
                                  SizedBox(height: 10.h),
                                  Row(
                                    children: [
                                      SizedText(
                                          text: 'Phone       : ',
                                          textStyle: latoB14.copyWith(
                                              color: Colors.white)),
                                      SizedBox(width: 20.w),
                                      SizedText(
                                          text: '01027212121',
                                          textStyle: latoR16.copyWith(
                                              color: Colors.white)),
                                    ],
                                  ),
                                ],
                              ),
                            )),
                        ExpandedButton(
                          text: 'OKAY',
                          onPressed: () {
                            appStore.dispatch(NavigateToAction(to: 'up'));
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

  Widget _buildTitleIcon() {
    return IconButton(
      padding: EdgeInsets.zero,
      iconSize: 25.w,
      icon: const Icon(Ionicons.chevron_back_outline),
      onPressed: () {
        appStore.dispatch(NavigateToAction(to: 'up'));
      },
    );
  }
}
