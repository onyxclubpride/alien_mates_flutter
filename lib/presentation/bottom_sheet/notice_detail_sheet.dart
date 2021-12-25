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

class NoticeDetail extends StatefulWidget {
  @override
  State<NoticeDetail> createState() => _NoticeDetailState();
}

class _NoticeDetailState extends State<NoticeDetail> {
  final GlobalKey<FormState> _formKeyNoticeDetail =
      GlobalKey<FormState>(debugLabel: '_formKeyNoticeDetail');

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
                      SizedText(),
                      // body: Image.network('https://picsum.photos/250?image=9'),
                      SpacedColumn(verticalSpace: 25, children: [
                        BasicInput(
                          isFocusBorderEnabled: false,
                          validator: Validator.validatePhoneNumber,
                          hintText: "Name",
                          controller: nameController,
                        ),
                        BasicInput(
                          isFocusBorderEnabled: false,
                          hintText: "Password",
                          controller: passController,
                          textInputAction: TextInputAction.done,
                          isObscured: true,
                        ),
                        if (errorText.isNotEmpty)
                          SizedText(
                            text: errorText,
                            textStyle:
                                latoM16.copyWith(color: ThemeColors.fontWhite),
                          ),
                        ExpandedButton(
                          text: 'LOGIN',
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
