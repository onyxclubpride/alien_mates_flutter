import 'package:alien_mates/mgr/navigation/app_routes.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:alien_mates/mgr/redux/action.dart';
import 'package:alien_mates/presentation/template/base/template.dart';

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
                              textInputAction: TextInputAction.done,
                              isObscured: true,
                            ),
                            if (errorText.isNotEmpty)
                              SizedText(
                                text: errorText,
                                textStyle: latoM16.copyWith(
                                    color: ThemeColors.fontWhite),
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
                                  textStyle: latoB14.apply(
                                      color: ThemeColors.fontWhite
                                          .withOpacity(0.5)),
                                ),
                                onTap: () {
                                  appStore.dispatch(NavigateToAction(
                                      to: AppRoutes.forgotPasswordPageRoute));
                                }),
                            InkWell(
                              child: SizedText(
                                text: 'Sign Up',
                                textStyle:
                                    latoB14.apply(color: ThemeColors.fontWhite),
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
          errorText = "Login Error! Please, try again!";
        });
      }
    }
  }

  _signUp() {
    appStore.dispatch(NavigateToAction(to: AppRoutes.signUpPageRoute));
  }
}
