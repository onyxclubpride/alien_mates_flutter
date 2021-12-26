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

class HelpDetail extends StatefulWidget {
  @override
  State<HelpDetail> createState() => _HelpDetailState();
}

class _HelpDetailState extends State<HelpDetail> {
  final GlobalKey<FormState> _formKeyHelpDetail =
      GlobalKey<FormState>(debugLabel: '_formKeyHelpDetail');

  TextEditingController nameController = TextEditingController(text: '');
  TextEditingController passController = TextEditingController(text: '');
  TextEditingController confirmPassController = TextEditingController(text: '');
  TextEditingController phoneNumberController =
      TextEditingController(text: '+82 ');
  TextEditingController otpController = TextEditingController(text: '');
  String errorText = "";

  @override
  void dispose() {
    passController.dispose();
    confirmPassController.dispose();
    otpController.dispose();
    super.dispose();
  }

  // Need changes

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
                      PostItemBanner(
                          child: CachedNetworkImage(
                        imageUrl: "https://picsum.photos/id/237/500/300",
                        fit: BoxFit.cover,
                      )),
                      SpacedColumn(verticalSpace: 25, children: [
                        Container(
                            height: 300.h,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  const Text(
                                    "Hello world, I needd help",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  const Text(
                                    "Contact",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Row(
                                    children: const [
                                      Text(
                                        "Kakao ID : ",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      Text(
                                        "Phone Nuber : ",
                                        style: TextStyle(color: Colors.white),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: const [
                                      Text(
                                        "Phone Nuber : ",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      Text(
                                        "Phone Nuber : ",
                                        style: TextStyle(color: Colors.white),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            )),
                        ExpandedButton(
                          text: 'OKAY',
                          onPressed: () {},
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
