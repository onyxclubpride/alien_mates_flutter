import 'package:alien_mates/mgr/redux/action.dart';
import 'package:alien_mates/mgr/redux/middleware/api_middleware.dart';
import 'package:alien_mates/presentation/template/base/template.dart';
import 'package:alien_mates/utils/common/global_widgets.dart';
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

  TextEditingController nameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController uniNameController = TextEditingController();

  int? sentOtp = 12345;
  String? verId;

  bool isOtpSent = false;
  bool isOtpCorrect = false;
  String errorText = "";
  bool isPhoneNumberAvailable = false;

  @override
  void dispose() {
    nameController.dispose();
    passController.dispose();
    confirmPassController.dispose();
    otpController.dispose();
    phoneNumberController.dispose();
    uniNameController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        onDidChange: (previousViewModel, viewModel) {
          if (viewModel.apiState.selectedUni.isNotEmpty) {
            setState(() {
              uniNameController =
                  TextEditingController(text: viewModel.apiState.selectedUni);
            });
          }
        },
        builder: (context, state) {
          return DefaultBody(
            withNavigationBar: false,
            withTopBanner: false,
            showAppBar: false,
            topPadding: 30,
            bottomPadding: 20,
            footer: ExpandedButton(
              text: isPhoneNumberAvailable
                  ? isOtpSent
                      ? 'Sign Up'
                      : "Send Otp"
                  : 'Check Phone Number',
              onPressed: () {
                if (isOtpSent) {
                  _signUpPress();
                } else {
                  _onSendOtp(state);
                }
              },
            ),
            child: SingleChildScrollView(
              child: Form(
                key: _formKeyForgotPasswordPage,
                child: SpacedColumn(
                  mainAxisAlignment: MainAxisAlignment.end,
                  verticalSpace: 21,
                  children: [
                    SizedText(
                        text: 'Forgot Password',
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
                          children: const [
                            SizedText(text: '+82'),
                          ],
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
                          // validator: Validator.validatePassword,
                          isObscured: true,
                        ),
                      if (isOtpCorrect)
                        BasicInput(
                          hintText: "Confirm Password",
                          controller: confirmPassController,
                          // validator: Validator.validatePassword,
                          isObscured: true,
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
            });
          }
        }
      }
    }
  }

  _onSendOtp(AppState state) async {
    bool userExists = await appStore
        .dispatch(GetCheckPhoneNumExistsAction(phoneNumberController.text));
    if (_formKeyForgotPasswordPage.currentState!.validate() &&
        phoneNumberController.text.isNotEmpty &&
        phoneNumberController.text.length > 10) {
      if (!userExists) {
        showLoading();
        setState(() {
          errorText = "";
        });
        try {
          await FirebaseAuth.instance.verifyPhoneNumber(
            phoneNumber: "+82" + phoneNumberController.text,
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
      } else {
        setState(() {
          errorText = 'The above phone number has already been registered!';
        });
      }
    }
  }

  _signUpPress() async {
    if (_formKeyForgotPasswordPage.currentState!.validate()) {
      if (_checkPwd()) {
        setState(() {
          errorText = "";
        });
        if (_formKeyForgotPasswordPage.currentState!.validate()) {
          bool matched = await appStore.dispatch(GetCreateUserAction(
              phoneNumber: phoneNumberController.text,
              password: passController.text,
              name: nameController.text,
              uniName: uniNameController.text));
          if (!matched) {
            setState(() {
              errorText =
                  "There is something wrong. Please check your data again";
            });
          } else {
            appStore.dispatch(NavigateToAction(to: 'up'));
          }
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
