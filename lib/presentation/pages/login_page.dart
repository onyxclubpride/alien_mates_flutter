import 'dart:developer';

import 'package:flutter/scheduler.dart';
import 'dart:io';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:smart_house_flutter/mgr/navigation/app_routes.dart';
// import 'package:smart_house_flutter/navigation/routes.dart';
import 'package:smart_house_flutter/mgr/redux/action.dart';
import 'package:smart_house_flutter/presentation/template/base/template.dart';
import 'package:flutter/material.dart';
import 'package:smart_house_flutter/mgr/redux/app_state.dart';
import 'package:smart_house_flutter/presentation/widgets/button/expanded_btn.dart';
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

  TextEditingController idController = TextEditingController();
  TextEditingController pwController = TextEditingController();
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
                      SizedText(
                          text: 'Alien Mates',
                          textStyle: latoB45.copyWith(color: Colors.white)),
                      SizedBox(
                        height: 25.h,
                      ),
                      SpacedColumn(verticalSpace: 25, children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BasicInput(
                              hintText: "Phone Number",
                              controller: idController,
                            ),
                          ],
                        ),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BasicInput(
                                hintText: "Password",
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
                  height: 1.h,
                ),
                SizedBox(
                  height: 19.h,
                ),
                if (!isLoading)
                  ExpandedButton(
                    text: 'LOGIN',
                    isGray: false,
                    onPressed: () {
                      appStore.dispatch(NavigateToAction(
                          to: AppRoutes.homePageRoute, replace: true));
                    },
                  )
                else
                  const CircularProgressIndicator(),
                SizedBox(height: 10.h),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SizedText(
                          text: 'Forgot Password?',
                          textStyle:
                              latoB14.apply(color: ThemeColors.fontWhite),
                        ),
                        SizedText(
                          text: 'Sign Up',
                          textStyle:
                              latoB14.apply(color: ThemeColors.fontWhite),
                        ),
                      ]),
                )
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
