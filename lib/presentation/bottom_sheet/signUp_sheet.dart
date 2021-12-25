import 'package:alien_mates/presentation/widgets/button/expanded_btn.dart';
import 'package:alien_mates/presentation/widgets/input/basic_input.dart';
import 'package:alien_mates/utils/common/validators.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ionicons/ionicons.dart';
import 'package:alien_mates/mgr/models/model_exporter.dart';
import 'package:alien_mates/mgr/navigation/app_routes.dart';
import 'package:alien_mates/mgr/redux/action.dart';
import 'package:alien_mates/mgr/redux/app_state.dart';
import 'package:alien_mates/mgr/redux/states/api_state.dart';
import 'package:alien_mates/presentation/template/base/template.dart';
import 'package:alien_mates/utils/common/log_tester.dart';

class SignUp extends StatefulWidget {
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKeySignUp =
      GlobalKey<FormState>(debugLabel: '_formKeySignUp');

  TextEditingController nameController = TextEditingController(text: '');
  TextEditingController passController = TextEditingController(text: '');
  TextEditingController confirmPassController = TextEditingController(text: '');
  TextEditingController phoneNumberController =
      TextEditingController(text: '+82 ');
  TextEditingController otpController = TextEditingController(text: '');
  String errorText = "";

  @override
  void dispose() {
    passController.dispose();
    confirmPassController.dispose();
    otpController.dispose();
    super.dispose();
  }

  _fireBaseAuth() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+44 7123 123 456',
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) {},
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  FirebaseAuth auth = FirebaseAuth.instance;

  // backgroundColor: Color.fromRGBO(r, g, b, 0)
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) {
          return SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                color: Colors.black,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20.w),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Form(
                    key: _formKeySignUp,
                    child: SpacedColumn(
                      verticalSpace: 21,
                      children: [
                        Container(
                          height: 3,
                          width: 70.w,
                          color: Colors.grey,
                        ),
                        SizedText(
                            text: 'Sign Up',
                            textStyle: latoB45.copyWith(color: Colors.white)),
                        SpacedColumn(verticalSpace: 25, children: [
                          BasicInput(
                            isFocusBorderEnabled: false,
                            validator: Validator.validatePhoneNumber,
                            hintText: "Name",
                            controller: nameController,
                          ),
                          BasicInput(
                            isFocusBorderEnabled: false,
                            hintText: "Password",
                            controller: passController,
                            textInputAction: TextInputAction.done,
                            isObscured: true,
                          ),
                          BasicInput(
                            isFocusBorderEnabled: false,
                            validator: Validator.validatePhoneNumber,
                            hintText: "Confirm Password",
                            textInputAction: TextInputAction.done,
                            controller: confirmPassController,
                            isObscured: true,
                          ),
                          BasicInput(
                            isFocusBorderEnabled: false,
                            hintText: "Phone Number",
                            controller: phoneNumberController,
                          ),
                          BasicInput(
                            isFocusBorderEnabled: false,
                            hintText: "OTP",
                            controller: otpController,
                          ),
                          if (errorText.isNotEmpty)
                            SizedText(
                              text: errorText,
                              textStyle: latoM16.copyWith(
                                  color: ThemeColors.fontWhite),
                            ),
                          ExpandedButton(
                            text: 'LOGIN',
                            onPressed: () {
                              print(nameController);
                              print(passController);
                              print(confirmPassController);
                              print(phoneNumberController);
                              print(otpController);
                            },
                          ),
                        ]),
                      ],
                    ),
                  ),
                ]),
              ),
            ),
          );
        });
  }
}
