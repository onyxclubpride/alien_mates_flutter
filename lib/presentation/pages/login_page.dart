import 'package:alien_mates/mgr/models/model_exporter.dart';
import 'package:alien_mates/mgr/navigation/app_routes.dart';
import 'package:alien_mates/presentation/widgets/bottom_sheet/help_detail_sheet.dart';
import 'package:alien_mates/presentation/widgets/bottom_sheet/notice_detail_sheet.dart';
import 'package:alien_mates/presentation/widgets/bottom_sheet/post_feed_sheet.dart';
import 'package:alien_mates/presentation/widgets/bottom_sheet/signUp_sheet.dart';
import 'package:alien_mates/utils/common/log_tester.dart';
import 'package:alien_mates/utils/common/validators.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:alien_mates/mgr/redux/action.dart';
import 'package:alien_mates/presentation/template/base/template.dart';
import 'package:flutter/material.dart';
import 'package:alien_mates/mgr/redux/app_state.dart';
import 'package:alien_mates/presentation/widgets/button/expanded_btn.dart';
import 'package:alien_mates/presentation/widgets/input/basic_input.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKeyLoginPage =
      GlobalKey<FormState>(debugLabel: '_formKeyLoginPage');

  TextEditingController phoneNumController =
      TextEditingController(text: '01064634085');
  TextEditingController pwController = TextEditingController(text: 'test1111');
  String errorText = "";

  @override
  void dispose() {
    phoneNumController.dispose();
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
                  key: _formKeyLoginPage,
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
                        BasicInput(
                          validator: Validator.validatePhoneNumber,
                          hintText: "Phone Number",
                          controller: phoneNumController,
                        ),
                        BasicInput(
                          hintText: "Password",
                          controller: pwController,
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
                          onPressed: _onLoginPress,
                        )
                      ]),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        InkWell(
                          child: SizedText(
                            text: 'Forget Password',
                            textStyle:
                                latoB14.apply(color: ThemeColors.fontWhite),
                          ),
                          onTap: () {
                            _noticeDetailSheet(context);
                          },
                        ),
                        InkWell(
                          child: SizedText(
                            text: 'Sign Up',
                            textStyle:
                                latoB14.apply(color: ThemeColors.fontWhite),
                          ),
                          onTap: () {
                            _signUp(context);
                          },
                        ),
                      ]),
                )
              ],
            ),
          );
        });
  }

  _onLoginPress() async {
    setState(() {
      errorText = "";
    });
    if (_formKeyLoginPage.currentState!.validate()) {
      bool matched = await appStore.dispatch(GetLoginAction(
          phoneNumber: phoneNumController.text, password: pwController.text));
      if (!matched) {
        setState(() {
          errorText = "User not found! Please, try again!";
        });
      }
    }
  }

  _signUp(context) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        enableDrag: true,
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return SignUp();
        });
  }

  _noticeDetailSheet(context) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        enableDrag: true,
        context: context,
        isScrollControlled: true,
        builder: (context) {
          // return NoticeDetail();
          // return HelpDetail();
          return PostFeed();
        });
  }
}
