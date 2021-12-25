import 'dart:developer';

import 'package:flutter/scheduler.dart';
import 'dart:io';
import 'package:flutter_redux/flutter_redux.dart';
// import 'package:smart_house_flutter/navigation/routes.dart';
import 'package:smart_house_flutter/mgr/redux/action.dart';
import 'package:smart_house_flutter/presentation/template/base/template.dart';
import 'package:flutter/material.dart';
import 'package:smart_house_flutter/mgr/redux/app_state.dart';
import 'package:smart_house_flutter/presentation/widgets/input/basic_input.dart';
import 'package:smart_house_flutter/presentation/widgets/input/input_label.dart';
import 'package:smart_house_flutter/utils/common/validators.dart';

// import 'package:alien_mates_flutter/utils/common/validators.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> _formAuthKey2 = GlobalKey<FormState>(debugLabel: '2');

  TextEditingController idController = TextEditingController(text: 'ibextest');
  TextEditingController pwController =
      TextEditingController(text: 'Ibex123!@#');
  // TextEditingController idController = TextEditingController(text: 'gmlwnd');
  // TextEditingController pwController = TextEditingController(text: 'Test0928!');
  // TextEditingController idController = TextEditingController();
  // TextEditingController pwController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    idController.dispose();
    pwController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) {
          return DefaultBody(
            withNavigationBar: false,
            withTopBanner: false,
            showAppBar: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Form(
                  onChanged: () {
                    setState(() {
                      idController = idController;
                    });
                  },
                  key: _formAuthKey2,
                  child: SpacedColumn(
                    verticalSpace: 21,
                    children: [
                      SizedText(text: 'login', textStyle: latoB45),
                      SpacedColumn(verticalSpace: 25, children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InputLabel(label: 'id'),
                            BasicInput(
                              hintText: "input",
                              controller: idController,
                            ),
                          ],
                        ),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InputLabel(label: 'password'),
                              BasicInput(
                                hintText: "input",
                                controller: pwController,
                                textInputAction: TextInputAction.done,
                                isObscured: true,
                              )
                            ])
                      ]),
                    ],
                  ),
                ),
                SizedBox(
                  height: 12.h,
                ),
                SizedBox(
                  height: 19.h,
                ),
                CircularProgressIndicator(),
                SizedBox(height: 10.h),
                SizedBox(
                  height: 39.h,
                ),
                SpacedRow(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  horizontalSpace: 19,
                  children: [
                    Expanded(
                      child: Container(
                        height: 1,
                        color: ThemeColors.gray1,
                      ),
                    ),
                    SizedText(
                      text: 'easy_login',
                      textStyle: latoR14.apply(color: ThemeColors.gray1),
                    ),
                    Expanded(
                      child: Container(
                        height: 1,
                        color: ThemeColors.gray1,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 34.h,
                ),
              ],
            ),
          );
        });
  }

  // _onLogin() async {
  //   if (_formAuthKey2.currentState!.validate()) {
  //     setState(() {
  //       isLoading = true;
  //     });
  //     bool success = await appStore.dispatch(GetLoginAction(
  //         loginReq: LoginReq(
  //             password: pwController.text, userId: idController.text)));
  //     if (success)
  //       appStore.dispatch(
  //           NavigateToAction(to: AppRoutes.RouteToNAT_MO_013, replace: true));
  //     setState(() {
  //       isLoading = false;
  //     });
  //   }
  // }

  // get _checkNextButton {
  //   if (pwController.text.isNotEmpty && idController.text.isNotEmpty) {
  //     return _onLogin;
  //   }
  //   return null;
  // }
}
