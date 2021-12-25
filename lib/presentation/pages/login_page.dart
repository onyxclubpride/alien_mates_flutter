import 'dart:developer';

import 'package:flutter/scheduler.dart';
import 'dart:io';
import 'package:flutter_redux/flutter_redux.dart';
// import 'package:smart_house_flutter/navigation/routes.dart';
import 'package:smart_house_flutter/mgr/redux/action.dart';
import 'package:smart_house_flutter/presentation/template/base/template.dart';
import 'package:flutter/material.dart';
import 'package:smart_house_flutter/mgr/redux/app_state.dart';

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
            child: Column(
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
                        text: 'login',
                        textStyle: ThemeTextMedium.notoM17,
                      ),
                      SpacedColumn(verticalSpace: 25, children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InputLabel(label: 'id'),
                            BasicInput(
                              hintText: "input",
                              controller: idController,
                              validator: Validator.validateId,
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
                                validator: Validator.validatePassword,
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
                if (state.apiState.clientError != null)
                  SizedText(
                    text: '${state.apiState.clientError}',
                    textStyle:
                    ThemeTextRegular.notoR13.apply(color: ThemeColors.red),
                  ),
                SizedBox(
                  height: 19.h,
                ),
                if (!isLoading)
                  ExpandedButton(
                    text: 'login',
                    onPressed: _checkNextButton,
                  )
                else
                  CircularProgressIndicator(),
                SizedBox(height: 10.h),
                SpacedRow(
                  horizontalSpace: 11,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextButtonSec(
                      text: 'id_password',
                      onPressed: () {
                        appStore.dispatch(
                            NavigateToAction(to: AppRoutes.RouteToNAT_MO_003));
                      },
                    ),
                    SizedText(
                      text: '|',
                      textStyle: ThemeTextRegular.notoR13,
                    ),
                    TextButtonSec(
                      text: 'register',
                      onPressed: () {
                        appStore.dispatch(UpdateUIAction(isSnsLogin: false));
                        appStore.dispatch(
                            NavigateToAction(to: AppRoutes.RouteToNAT_MO_005));
                      },
                    ),
                  ],
                ),
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
                        color: ThemeColors.gray2,
                      ),
                    ),
                    SizedText(
                      text: 'easy_login',
                      textStyle: ThemeTextRegular.notoR13
                          .apply(color: ThemeColors.gray4),
                    ),
                    Expanded(
                      child: Container(
                        height: 1,
                        color: ThemeColors.gray2,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 34.h,
                ),
                Row(
                  mainAxisAlignment: Platform.isAndroid
                      ? MainAxisAlignment.spaceAround
                      : MainAxisAlignment.spaceBetween,
                  children: [
                    SpacedColumn(verticalSpace: 8, children: [
                      CustomIcon(
                        imagePath: 'assets/icons/kakao_ic.png',
                        height: 50.h,
                        onTap: () {
                          appStore.dispatch(
                              GetSnsLoginAction(snsType: SnsType.kakao));
                        },
                      ),
                      SizedText(
                        text: 'kakaotalk',
                        textStyle: ThemeTextRegular.notoR13,
                      )
                    ]),
                    SpacedColumn(verticalSpace: 8, children: [
                      CustomIcon(
                        imagePath: 'assets/icons/naver_ic.png',
                        height: 50.h,
                        onTap: () {
                          appStore.dispatch(
                              GetSnsLoginAction(snsType: SnsType.naver));
                        },
                      ),
                      SizedText(
                        text: 'naver',
                        textStyle: ThemeTextRegular.notoR13,
                      )
                    ]),
                    SpacedColumn(verticalSpace: 8, children: [
                      CustomIcon(
                        imagePath: 'assets/icons/google_ic.png',
                        height: 50.h,
                        onTap: () {
                          appStore.dispatch(
                              GetSnsLoginAction(snsType: SnsType.google));
                        },
                      ),
                      SizedText(
                        text: 'google',
                        textStyle: ThemeTextRegular.notoR13,
                      )
                    ]),
                    if (!Platform.isAndroid)
                      SpacedColumn(verticalSpace: 8, children: [
                        CustomIcon(
                          imagePath: 'assets/icons/apple_ic.png',
                          height: 50.h,
                          onTap: () {
                            appStore.dispatch(
                                GetSnsLoginAction(snsType: SnsType.apple));
                          },
                        ),
                        SizedText(
                          text: 'apple',
                          textStyle: ThemeTextRegular.notoR13,
                        )
                      ])
                  ],
                )
              ],
            ),
            paddingTop: 18,
            paddingBottom: 26,
            paddingHorizontal: 18,
          );
        });
  }

  _onLogin() async {
    if (_formAuthKey2.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      bool success = await appStore.dispatch(GetLoginAction(
          loginReq: LoginReq(
              password: pwController.text, userId: idController.text)));
      if (success)
        appStore.dispatch(
            NavigateToAction(to: AppRoutes.RouteToNAT_MO_013, replace: true));
      setState(() {
        isLoading = false;
      });
    }
  }

  get _checkNextButton {
    if (pwController.text.isNotEmpty && idController.text.isNotEmpty) {
      return _onLogin;
    }
    return null;
  }
}
