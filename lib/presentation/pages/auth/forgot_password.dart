import 'package:alien_mates/mgr/redux/action.dart';
import 'package:alien_mates/presentation/template/base/template.dart';
import 'package:alien_mates/presentation/widgets/show_body_dialog.dart';
import 'package:alien_mates/utils/common/global_widgets.dart';
import 'package:alien_mates/utils/common/log_tester.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ionicons/ionicons.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final GlobalKey<FormState> _formKeyForgotPasswordPage =
      GlobalKey<FormState>(debugLabel: '_formKeySignupPage');

  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  int? sentOtp = 12345;
  bool isOtpSent = false;
  bool isOtpCorrect = false;
  bool isPhoneNumberAvailable = false;
  bool isButtonDisable = false;
  String? verId;
  String errorText = "";

  @override
  void dispose() {
    passController.dispose();
    confirmPassController.dispose();
    otpController.dispose();
    phoneNumberController.dispose();
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
            child: SpacedColumn(children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                    onPressed: () {
                      showBodyDialog(
                        context,
                        text: 'Are you sure?',
                        onMainButtonText: 'Yes',
                        onPress: () {
                          appStore.dispatch(NavigateToAction(to: "up"));
                        },
                      );
                    },
                    icon: Icon(
                      Ionicons.chevron_back_outline,
                      color: Colors.white,
                      size: 30.h,
                    )),
              ),
              Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKeyForgotPasswordPage,
                    child: SpacedColumn(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(height: 20.h),
                        SizedText(
                            text: 'Reset Password',
                            textStyle: latoB45.copyWith(color: Colors.white)),
                        if (!isOtpSent) SizedBox(height: 20.h),
                        SpacedColumn(verticalSpace: 25, children: [
                          BasicInput(
                            validator: Validator.validatePhoneNumber,
                            hintText: "Phone Number",
                            readOnly: isOtpCorrect,
                            keyboardType: TextInputType.number,
                            icon: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [SizedText(text: '+82')],
                            ),
                            controller: phoneNumberController,
                          ),
                          if (isPhoneNumberAvailable)
                            if (isOtpSent)
                              BasicInput(
                                hintText: "OTP",
                                readOnly: isOtpCorrect,
                                controller: otpController,
                                onChanged: _enteringSmsCode,
                                validator: Validator.validateOtp,
                                keyboardType: TextInputType.number,
                                suffixIcon: IconButton(
                                  onPressed: null,
                                  icon: Icon(
                                    Ionicons.checkmark_done_sharp,
                                    color: isOtpCorrect
                                        ? Colors.blueAccent
                                        : ThemeColors.transparent,
                                  ),
                                ),
                              ),
                          if (isOtpCorrect)
                            BasicInput(
                              hintText: "Password",
                              controller: passController,
                              validator: Validator.validatePassword,
                              isObscured: true,
                            ),
                          if (isOtpCorrect)
                            BasicInput(
                              hintText: "Confirm Password",
                              validator: Validator.validatePassword,
                              isObscured: true,
                              controller: confirmPassController,
                            ),
                          if (errorText.isNotEmpty)
                            SizedText(
                              text: errorText,
                              textStyle:
                                  latoM16.copyWith(color: ThemeColors.red),
                            ),
                        ]),
                      ],
                    ),
                  ),
                ),
              ),
            ]),
            footer: !isButtonDisable
                ? ExpandedButton(
                    text:
                        isPhoneNumberAvailable ? 'Change Password' : "Send OTP",
                    onPressed: () {
                      if (!isPhoneNumberAvailable) {
                        _checkPhoneNumberPress(state);
                      } else if (isOtpSent) {
                        // update backend
                        setState(() {
                          isButtonDisable = false;
                        });
                        _onChangePasswordPress();
                      } else {
                        setState(() {
                          isButtonDisable = false;
                        });
                      }
                    },
                  )
                : null,
          );
        });
  }

  _enteringSmsCode(value) async {
    String phoneNumber = "+82${phoneNumberController.text}";
    if (phoneNumberController.text.startsWith("0")) {
      phoneNumber = "+82${phoneNumberController.text.substring(1)}";
    }
    if (value.toString().length == 6) {
      // Update the UI - wait for the user to enter the SMS code
      String smsCode = value;
      // Create a PhoneAuthCredential with the code
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verId!, smsCode: smsCode);
      // Sign the user in (or link) with the credential
      final res = await FirebaseAuth.instance.signInWithCredential(credential);
      if (res.user != null) {
        if (res.user!.phoneNumber == phoneNumber) {
          bool userExists = await appStore
              .dispatch(GetCheckPhoneNumberExistsAction(phoneNumber));
          if (!userExists) {
            setState(() {
              isOtpCorrect = true;
              isButtonDisable = false;
            });
          }
        }
      }
    }
  }

  _onSendOtp(AppState state) async {
    showLoading();
    setState(() {
      errorText = "";
    });
    try {
      String phNum = phoneNumberController.text;
      if (!phNum.startsWith('0')) {
        phNum = "0${phoneNumberController.text}";
      }
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "+82" + phNum,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // await FirebaseAuth.instance.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          closeLoading();
          showAlertDialog(context, text: e.message.toString());
          setState(() {
            isOtpSent = false;
          });
        },
        forceResendingToken: sentOtp,
        timeout: const Duration(milliseconds: 20000),
        codeSent: (String verificationId, int? resendToken) async {
          closeLoading();
          setState(() {
            isOtpSent = true;
            sentOtp = resendToken;
            verId = verificationId;
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          closeLoading();
          setState(() {
            verId = verificationId;
          });
        },
      );
    } catch (e) {
      closeLoading();
      setState(() {
        isOtpSent = false;
      });
    }
  }

  _checkPhoneNumberPress(AppState state) async {
    if (_formKeyForgotPasswordPage.currentState!.validate() &&
        phoneNumberController.text.isNotEmpty &&
        phoneNumberController.text.length > 9) {
      String phNum = phoneNumberController.text;
      if (!phNum.startsWith('0')) {
        phNum = "0${phoneNumberController.text}";
      }
      bool userExists =
          await appStore.dispatch(GetCheckPhoneNumExistsAction(phNum));

      if (userExists) {
        setState(() {
          isPhoneNumberAvailable = true;
          isButtonDisable = true;
          errorText = "";
        });
        _onSendOtp(state);
      } else {
        setState(() {
          isButtonDisable = false;
          errorText = "There is no account with this number.";
        });
      }
      return userExists;
    } else {
      setState(() {
        errorText = "Phone Number should be more than 9";
      });
    }
  }

  _onChangePasswordPress() async {
    if (_formKeyForgotPasswordPage.currentState!.validate()) {
      if (_checkPwd()) {
        setState(() {
          errorText = "";
        });
        String phNum = phoneNumberController.text;
        if (!phNum.startsWith('0')) {
          phNum = "0${phoneNumberController.text}";
        }
        bool matched = await appStore.dispatch(GetChangePasswordAction(
            newPassword: passController.text, phoneNumber: phNum));
        if (!matched) {
          setState(() {
            errorText =
                "There is something wrong. Please check your data again";
          });
        } else {
          appStore.dispatch(NavigateToAction(to: 'up'));
        }
      } else {
        setState(() {
          // errorText = "Password do not match!";
        });
      }
    }
  }

  bool _checkPwd() {
    bool isSame = false;
    if (passController.text == confirmPassController.text) {
      isSame = true;
    } else {
      setState(() {
        errorText = "Password didn't match";
      });
      isSame = false;
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
