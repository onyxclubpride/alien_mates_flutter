import 'package:alien_mates/mgr/redux/action.dart';
import 'package:alien_mates/presentation/template/base/template.dart';
import 'package:alien_mates/presentation/widgets/button/expanded_btn.dart';
import 'package:alien_mates/presentation/widgets/input/basic_input.dart';
import 'package:alien_mates/presentation/widgets/show_alert_dialog.dart';
import 'package:alien_mates/utils/common/global_widgets.dart';
import 'package:alien_mates/utils/common/log_tester.dart';
import 'package:alien_mates/utils/common/validators.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ionicons/ionicons.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKeySignUpPage =
      GlobalKey<FormState>(debugLabel: '_formKeySignupPage');

  TextEditingController nameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController uniNameController = TextEditingController();

  int? sentOtp;

  bool isOtpSent = false;
  bool isOtpCorrect = false;
  String errorText = "";

  @override
  void dispose() {
    passController.dispose();
    confirmPassController.dispose();
    otpController.dispose();
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
            topPadding: 30,
            bottomPadding: 20,
            footer: ExpandedButton(
              text: isOtpSent ? 'Sign Up' : "Send Otp",
              onPressed: isOtpSent ? _signUpPress : _onSendOtp,
            ),
            child: SingleChildScrollView(
              child: Form(
                key: _formKeySignUpPage,
                child: SpacedColumn(
                  mainAxisAlignment: MainAxisAlignment.end,
                  verticalSpace: 21,
                  children: [
                    SizedText(
                        text: 'Sign Up',
                        textStyle: latoB45.copyWith(color: Colors.white)),
                    if (!isOtpSent) SizedBox(height: 20.h),
                    SpacedColumn(verticalSpace: 25, children: [
                      BasicInput(
                        validator: Validator.validateName,
                        hintText: "Name",
                        controller: nameController,
                      ),
                      BasicInput(
                        hintText: "Password",
                        controller: passController,
                        validator: Validator.validatePassword,
                        isObscured: true,
                      ),
                      BasicInput(
                        hintText: "Confirm Password",
                        controller: confirmPassController,
                        // validator: Validator.validatePassword,
                        isObscured: true,
                      ),
                      BasicInput(
                        validator: Validator.validatePhoneNumber,
                        hintText: "Phone Number",
                        keyboardType: TextInputType.number,
                        icon: Padding(
                          padding: EdgeInsets.only(top: 12.h),
                          child: const SizedText(text: '+82'),
                        ),
                        controller: phoneNumberController,
                      ),
                      BasicInput(
                        hintText: "OTP",
                        readOnly: !isOtpSent,
                        controller: otpController,
                        validator: Validator.validateOtp,
                        keyboardType: TextInputType.number,
                        suffixIcon: IconButton(
                          onPressed: _onVerifyOtp,
                          icon: Icon(
                            Ionicons.checkmark_done,
                            color: isOtpSent
                                ? ThemeColors.bgDark
                                : ThemeColors.fontWhite,
                          ),
                        ),
                      ),
                      if (isOtpCorrect)
                        BasicInput(
                          hintText: "University Name",
                          textInputAction: TextInputAction.done,
                          controller: uniNameController,
                          readOnly: true,
                          onTap: _onSearchUniPress,
                        ),
                      if (errorText.isNotEmpty)
                        SizedText(
                          text: errorText,
                          textStyle: latoM16.copyWith(color: ThemeColors.red),
                        ),
                    ]),
                  ],
                ),
              ),
            ),
          );
        });
  }

  _onSearchUniPress() {
    //TODO: SHOH
  }

  _onSendOtp() async {
    if (phoneNumberController.text.isNotEmpty &&
        phoneNumberController.text.length == 10) {
      showLoading();
      setState(() {
        errorText = "";
      });
      try {
        await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: "+82" + phoneNumberController.text,
          verificationCompleted: (PhoneAuthCredential credential) {},
          verificationFailed: (FirebaseAuthException e) {
            closeLoading();
            showAlertDialog(context, text: e.message.toString());
            setState(() {
              isOtpSent = false;
            });
          },
          codeSent: (String verificationId, int? resendToken) {
            closeLoading();
            setState(() {
              isOtpSent = true;
              sentOtp = resendToken;
            });
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            closeLoading();
          },
        );
      } catch (e) {
        closeLoading();
        setState(() {
          isOtpSent = false;
        });
        logger(e.toString());
      }
    } else {
      setState(() {
        errorText = 'Phone number must be 10 digits!';
      });
    }
  }

  _onVerifyOtp() async {}

  _signUpPress() async {
    if (_formKeySignUpPage.currentState!.validate()) {
      if (_checkPwd()) {
        setState(() {
          errorText = "";
        });
        if (_formKeySignUpPage.currentState!.validate()) {
          // bool matched = await appStore.dispatch(GetCreateUserAction(
          //     phoneNumber: phoneNumberController.text,
          //     password: passController.text,
          //     name: nameController.text,
          //     uniName: uniNameController.text));
          // if (!matched) {
          //   setState(() {
          //     errorText =
          //         "There is something wrong. Please check your data again";
          //   });
          // }
        }
      } else {
        setState(() {
          errorText = "Passwords do not match!";
        });
      }
    }
  }

  bool _checkPwd() {
    bool isSame = false;
    if (passController.text == confirmPassController.text) {
      isSame = true;
    }
    return isSame;
  }

  showLoading() {
    showLoadingDialog(Global.navState!.context);
  }

  closeLoading() {
    appStore.dispatch(DismissPopupAction(all: true));
  }
}
