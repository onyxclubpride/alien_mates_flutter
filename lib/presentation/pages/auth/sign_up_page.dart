import 'package:alien_mates/mgr/models/univ_model/univ_model.dart';
import 'package:alien_mates/mgr/redux/action.dart';
import 'package:alien_mates/mgr/redux/middleware/api_middleware.dart';
import 'package:alien_mates/presentation/template/base/template.dart';
import 'package:alien_mates/utils/common/global_widgets.dart';
import 'package:alien_mates/utils/common/log_tester.dart';
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

  int? sentOtp = 12345;
  String? verId;

  bool isOtpSent = false;
  bool isOtpCorrect = false;
  String errorText = "";

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
    appStore.dispatch(GetSearchUniversityAction());
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
              text: isOtpSent ? 'Sign Up' : "Send Otp",
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
                        // validator: Validator.validatePassword,
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
                          hintText: "University Name",
                          textInputAction: TextInputAction.done,
                          controller: uniNameController,
                          validator: Validator.validateName,
                          suffixIcon: IconButton(
                            onPressed: _onSearchUniPress,
                            icon: const Icon(
                              Ionicons.search,
                              color: ThemeColors.componentBgDark,
                            ),
                          ),
                          onTap: _onSearchUniPress,
                          readOnly: true,
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

  _onSearchUniPress() {
    showModalBottomSheet(
      context: context,
      backgroundColor: ThemeColors.transparent,
      builder: (context) {
        return UniversitiesWidget();
      },
    );
  }

  _onSendOtp(AppState state) async {
    bool userExists = await appStore
        .dispatch(GetCheckPhoneNumExistsAction(phoneNumberController.text));
    if (_formKeySignUpPage.currentState!.validate() &&
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
    if (_formKeySignUpPage.currentState!.validate()) {
      if (_checkPwd()) {
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

class UniversitiesWidget extends StatefulWidget {
  @override
  _UniversitiesWidgetState createState() => _UniversitiesWidgetState();
}

class _UniversitiesWidgetState extends State<UniversitiesWidget> {
  List<UnivModelRes> univs = [];
  TextEditingController uniNameController = TextEditingController();

  @override
  void dispose() {
    uniNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) => Container(
              margin: EdgeInsets.symmetric(horizontal: 10.w),
              padding: EdgeInsets.only(right: 20.w, left: 20.w, top: 20.h),
              decoration: BoxDecoration(
                  color: ThemeColors.componentBgDark,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(16.r),
                      topLeft: Radius.circular(16.r))),
              child: SpacedColumn(
                crossAxisAlignment: CrossAxisAlignment.start,
                verticalSpace: 14,
                children: [
                  BasicInput(
                    hintText: "University Name",
                    textInputAction: TextInputAction.done,
                    controller: uniNameController,
                    validator: Validator.validateName,
                    suffixIcon: IconButton(
                      onPressed: () async {
                        showLoading();
                        List<UnivModelRes>? _univs = await appStore.dispatch(
                            GetSearchUniversityAction(
                                name: uniNameController.text));
                        appStore.dispatch(DismissPopupAction());
                        if (_univs != null) {
                          setState(() {
                            univs = _univs;
                          });
                        }
                      },
                      icon: const Icon(
                        Ionicons.search,
                        color: ThemeColors.componentBgDark,
                      ),
                    ),
                  ),
                  Container(
                    height: 280.h,
                    child: SingleChildScrollView(
                      child: SpacedColumn(
                        verticalSpace: 10,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _getUnivItem(state.apiState.univs),
                      ),
                    ),
                  ),
                ],
              ),
            ));
  }

  List<Widget> _getUnivItem(List<UnivModelRes> univs) {
    List<Widget> list = [];
    for (int i = 0; i < univs.length; i++) {
      list.add(InkWell(
        onTap: () {
          appStore.dispatch(UpdateApiStateAction(selectedUni: univs[i].name));
          appStore.dispatch(DismissPopupAction());
        },
        child: SizedText(
          textAlign: TextAlign.start,
          text: univs[i].name,
          textStyle: latoM20.copyWith(color: ThemeColors.fontWhite),
        ),
      ));
    }

    return list;
  }
}
