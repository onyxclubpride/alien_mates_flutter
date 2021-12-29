import 'package:alien_mates/mgr/models/univ_model/univ_model.dart';
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
                      // if (isOtpSent)
                      BasicInput(
                        hintText: "OTP",
                        readOnly: isOtpCorrect,
                        controller: otpController,
                        onChanged: (value) {
                          logger(value);
                          logger(sentOtp);

                          if (value.toString() == sentOtp.toString()) {
                            setState(() {
                              isOtpCorrect = true;
                            });
                          }
                        },
                        validator: Validator.validateOtp,
                        keyboardType: TextInputType.number,
                        suffixIcon: IconButton(
                          onPressed: _onVerifyOtp,
                          icon: Icon(
                            Ionicons.checkmark_done_sharp,
                            color: isOtpCorrect
                                ? Colors.blueAccent
                                : ThemeColors.transparent,
                          ),
                        ),
                      ),
                      // if (isOtpCorrect)
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

  _onSearchUniPress() {
    showModalBottomSheet(
      context: context,
      backgroundColor: ThemeColors.transparent,
      builder: (context) {
        return UniversitiesWidget();
      },
    );
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
              logger(sentOtp, hint: 'TOKEN');
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
            // appStore.dispatch(NavigateToAction(to: 'up'));
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
                        List<UnivModelRes>? _univs = await appStore.dispatch(
                            GetSearchUniversityAction(
                                name: uniNameController.text));
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
