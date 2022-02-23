import 'package:alien_mates/mgr/models/univ_model/univ_model.dart';
import 'package:alien_mates/mgr/redux/action.dart';
import 'package:alien_mates/mgr/redux/middleware/api_middleware.dart';
import 'package:alien_mates/presentation/template/base/template.dart';
import 'package:alien_mates/presentation/widgets/show_body_dialog.dart';
import 'package:alien_mates/utils/common/global_widgets.dart';
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
  String buttonText = "Send Otp";

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

  // Initially password is obscure
  bool _obscurePass = true;
  bool _obscureConfirmPass = true;

  // Toggles the password show status
  void _togglePass() {
    setState(() {
      _obscurePass = !_obscurePass;
    });
  }

  void _toggleConfirmPass() {
    setState(() {
      _obscureConfirmPass = !_obscureConfirmPass;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        showBodyDialog(
          context,
          text: 'Are you sure?',
          onMainButtonText: 'Go Back',
          onPress: () {
            appStore.dispatch(NavigateToAction(to: "up"));
          },
        );
        return Future.value(false);
      },
      child: StoreConnector<AppState, AppState>(
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
              leftButton: IconButton(
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
              footer: ExpandedButton(
                text: isOtpSent ? 'Sign Up' : buttonText,
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
                          validator: Validator.validatePassword,
                          isObscured: _obscurePass,
                          suffixIcon: IconButton(
                            icon: _obscurePass
                                ? const Icon(Ionicons.eye)
                                : const Icon(Ionicons.eye_off_outline),
                            onPressed: _togglePass,
                          ),
                        ),
                        BasicInput(
                          hintText: "Confirm Password",
                          controller: confirmPassController,
                          isObscured: _obscureConfirmPass,
                          suffixIcon: IconButton(
                            icon: _obscureConfirmPass
                                ? const Icon(Ionicons.eye)
                                : const Icon(Ionicons.eye_off_outline),
                            onPressed: _toggleConfirmPass,
                          ),
                        ),
                        BasicInput(
                          validator: Validator.validatePhoneNumber,
                          hintText: "Phone Number",
                          textInputAction: TextInputAction.done,
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
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
                              SizedText(
                                text:
                                    'Validation is automatic, after entering 6 digits.\nPlease wait!',
                                textAlign: TextAlign.left,
                                textStyle:
                                    latoM16.copyWith(color: ThemeColors.white),
                              ),
                            ],
                          ),
                        if (isOtpCorrect)
                          BasicInput(
                            onTap: _onSearchUniPress,
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
                            readOnly: true,
                          ),
                        if (errorText.isNotEmpty)
                          SizedText(
                            text: errorText,
                            textStyle: latoM16.copyWith(color: ThemeColors.red),
                          ),
                      ]),
                      SizedBox(
                        height: 50.h,
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
    );
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
        return SizedBox(
            child: SingleChildScrollView(child: UniversitiesWidget()));
      },
    );
  }

  _onSendOtp(AppState state) async {
    String phNum = phoneNumberController.text;
    if (!phNum.startsWith('0')) {
      phNum = "0${phoneNumberController.text}";
    }
    bool userExists =
        await appStore.dispatch(GetCheckPhoneNumExistsAction(phNum));
    if (_formKeySignUpPage.currentState!.validate() &&
        phoneNumberController.text.isNotEmpty &&
        phoneNumberController.text.length > 9) {
      if (!userExists) {
        setState(() {
          errorText = "";
        });
        if (passController.text == confirmPassController.text) {
          setState(() {
            errorText = "";
            buttonText = "Please Wait. . .";
          });
          try {
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
        } else {
          setState(() {
            errorText = "Password did not match";
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
        if (uniNameController.text.isNotEmpty) {
          setState(() {
            errorText = "";
          });
          String phNum = phoneNumberController.text;
          if (!phNum.startsWith('0')) {
            phNum = "0${phoneNumberController.text}";
          }
          bool matched = await appStore.dispatch(GetCreateUserAction(
              phoneNumber: phNum,
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
          errorText = "Passwords did not match!";
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
                    onFieldSubmitted: (p0) {
                      func();
                    },
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
                  SizedBox(
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

  func() async {
    List<UnivModelRes>? _univs = await appStore
        .dispatch(GetSearchUniversityAction(name: uniNameController.text));
    if (_univs != null) {
      setState(() {
        univs = _univs;
      });
    }
  }
}
