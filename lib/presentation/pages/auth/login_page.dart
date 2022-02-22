import 'package:alien_mates/mgr/navigation/app_routes.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:alien_mates/mgr/redux/action.dart';
import 'package:alien_mates/presentation/template/base/template.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKeyLoginPage =
      GlobalKey<FormState>(debugLabel: '_formKeyLoginPage');

  TextEditingController phoneNumController = TextEditingController();
  TextEditingController pwController = TextEditingController();
  String errorText = "";

  DateTime timeBackPressed = DateTime.now();

  bool isliking = false;
  String likingpostid = "";
  bool startLiking = false;

  @override
  void dispose() {
    phoneNumController.dispose();
    pwController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: StoreConnector<AppState, AppState>(
          converter: (store) => store.state,
          builder: (context, state) {
            return DefaultBody(
              withNavigationBar: false,
              withTopBanner: false,
              showAppBar: false,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Form(
                        key: _formKeyLoginPage,
                        child: SpacedColumn(
                          verticalSpace: 21,
                          children: [
                            SizedText(
                                text: 'Alien Mates',
                                textStyle: latoB45.copyWith(
                                    color: ThemeColors.coolgray300)),
                            SizedBox(
                              height: 20.h,
                            ),
                            SpacedColumn(verticalSpace: 25, children: [
                              BasicInput(
                                validator: Validator.validatePhoneNumber,
                                hintText: "Phone Number",
                                keyboardType: TextInputType.number,
                                controller: phoneNumController,
                              ),
                              BasicInput(
                                hintText: "Password",
                                controller: pwController,
                                validator: Validator.validatePassword,
                                textInputAction: TextInputAction.done,
                                isObscured: true,
                              ),
                              if (errorText.isNotEmpty)
                                SizedText(
                                  text: errorText,
                                  textStyle: latoM16.copyWith(
                                      color: ThemeColors.fontWhite),
                                ),
                              Padding(
                                padding: EdgeInsets.all(8.0.w),
                                child: ExpandedButton(
                                  text: 'LOGIN',
                                  onPressed: _onLoginPress,
                                ),
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
                                    text: 'Reset Password',
                                    textStyle: latoB14.apply(
                                        color: ThemeColors.fontWhite),
                                  ),
                                  onTap: () {
                                    appStore.dispatch(NavigateToAction(
                                        to: AppRoutes.forgotPasswordPageRoute));
                                  }),
                              InkWell(
                                child: SizedText(
                                  text: 'Sign Up',
                                  textStyle: latoB14.apply(
                                      color: ThemeColors.fontWhite),
                                ),
                                onTap: _signUp,
                              ),
                            ]),
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  _onLoginPress() async {
    setState(() {
      errorText = "";
    });
    if (_formKeyLoginPage.currentState!.validate()) {
      String phNum = phoneNumController.text;
      if (!phNum.startsWith('0')) {
        phNum = "0${phoneNumController.text}";
      }
      bool matched = await appStore.dispatch(
          GetLoginAction(phoneNumber: phNum, password: pwController.text));
      if (!matched) {
        setState(() {
          errorText = "Login Error! Please, try again!";
        });
      }
    }
  }

  _signUp() {
    appStore.dispatch(NavigateToAction(to: AppRoutes.signUpPageRoute));
  }

  Future<bool> _onWillPop() {
    final difference = DateTime.now().difference(timeBackPressed);
    final isExitWarning = difference >= const Duration(seconds: 2);

    timeBackPressed = DateTime.now();

    if (isExitWarning) {
      const message = 'Press back again to exit';
      Fluttertoast.showToast(
          msg: message,
          fontSize: 18,
          backgroundColor: ThemeColors.white,
          textColor: ThemeColors.bluegray800);
      return Future.value(false);
    } else {
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      return Future.value(false);
    }
  }
}
