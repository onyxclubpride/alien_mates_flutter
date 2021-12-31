/////////////////
///MAKE IT A PAGE INSTED OF SHEET
////////////////

import 'package:alien_mates/presentation/widgets/button/expanded_btn.dart';
import 'package:alien_mates/presentation/widgets/input/basic_input.dart';
import 'package:alien_mates/presentation/widgets/show_alert_dialog.dart';
import 'package:alien_mates/utils/common/log_tester.dart';
import 'package:alien_mates/utils/common/validators.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:alien_mates/mgr/redux/action.dart';
import 'package:alien_mates/mgr/redux/app_state.dart';
import 'package:alien_mates/presentation/template/base/template.dart';
import 'package:ionicons/ionicons.dart';

class SignUp extends StatefulWidget {
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKeySignUpPage =
      GlobalKey<FormState>(debugLabel: '_formKeySignupPage');

  TextEditingController nameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController uniNameController = TextEditingController();

  int? sentOtp;
  int? userOtp;

  bool isOtpSent = false;
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
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 5.w),
            padding: EdgeInsets.only(
                left: 10.w,
                right: 10.w,
                bottom: MediaQuery.of(context).viewInsets.bottom),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.r),
                  topRight: Radius.circular(20.r)),
              color: ThemeColors.black,
            ),
            child: SingleChildScrollView(
              child: Form(
                key: _formKeySignUpPage,
                child: SpacedColumn(
                  mainAxisAlignment: MainAxisAlignment.end,
                  verticalSpace: 21,
                  children: [
                    GestureDetector(
                      onTap: () {
                        appStore.dispatch(DismissPopupAction());
                      },
                      child: Container(
                        height: 3.h,
                        width: 70.w,
                        color: Colors.grey,
                      ),
                    ),
                    SizedText(
                        text: 'Sign Up',
                        textStyle: latoB45.copyWith(color: Colors.white)),
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
                        validator: Validator.validatePassword,
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
                      if (otpController.text == sentOtp.toString())
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
                          textStyle:
                              latoM16.copyWith(color: ThemeColors.fontWhite),
                        ),
                      ExpandedButton(
                        text: isOtpSent ? 'Sign Up' : "Send Otp",
                        onPressed: otpController.text.isNotEmpty
                            ? sentOtp == int.parse(otpController.text).toInt()
                                ? _signUpPress
                                : _onSendOtp
                            : _onSendOtp,
                      ),
                      SizedBox(height: 5.h)
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
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "+82" + phoneNumberController.text,
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {
          showAlertDialog(context, text: e.message.toString());
          setState(() {
            isOtpSent = false;
          });
        },
        codeSent: (String verificationId, int? resendToken) {
          setState(() {
            isOtpSent = true;
          });
          setState(() {
            sentOtp = resendToken;
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      setState(() {
        isOtpSent = false;
      });
      logger(e.toString());
    }
  }

  _onVerifyOtp() async {}

  _signUpPress() async {
    setState(() {
      errorText = "";
    });
    if (_formKeySignUpPage.currentState!.validate()) {
      bool matched = await appStore.dispatch(GetCreateUserAction(
          phoneNumber: phoneNumberController.text,
          password: passController.text,
          name: nameController.text,
          uniName: uniNameController.text));
      if (!matched) {
        setState(() {
          errorText = "There is something wrong. Please check your data again";
        });
      }
    }
  }
}
