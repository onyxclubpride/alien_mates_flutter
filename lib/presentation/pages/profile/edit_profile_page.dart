import 'dart:io';
import 'package:alien_mates/mgr/redux/middleware/api_middleware.dart';
import 'package:alien_mates/mgr/redux/states/api_state.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:alien_mates/mgr/redux/action.dart';
import 'package:alien_mates/presentation/template/base/template.dart';
import 'package:ionicons/ionicons.dart';

class EditProfilePage extends StatefulWidget {
  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final GlobalKey<FormState> _formKeyEditProfilePage =
      GlobalKey<FormState>(debugLabel: '_formKeyEditProfilePage');

  TextEditingController userName = TextEditingController();

  TextEditingController currentPass = TextEditingController();
  TextEditingController newPass = TextEditingController();
  TextEditingController confirmNewPass = TextEditingController();

  File? noticeImage;

  String? pwErrorText;
  String? pwErrorTextCurr;
  String? pwErrorTextName;

  bool isPwChange = false;

  @override
  void dispose() {
    userName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        onInit: (store) {
          userName =
              TextEditingController(text: store.state.apiState.userMe.name);
        },
        builder: (context, state) {
          return DefaultBody(
            withNavigationBar: false,
            withTopBanner: false,
            withActionButton: false,
            titleIcon: _buildTitleIcon(),
            titleText: SizedText(text: 'Edit Profile', textStyle: latoM20),
            bottomPadding: 15.h,
            child: SizedBox(
              height: MediaQuery.of(context).size.height - 140.h,
              child: Form(
                key: _formKeyEditProfilePage,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // if (userName.text.isNotEmpty)
                      DefaultBanner(
                        bgColor: ThemeColors.black,
                        child: Container(
                          padding: EdgeInsets.all(12.w),
                          child: SpacedColumn(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedText(
                                  text: 'User',
                                  textStyle: latoR14.copyWith(
                                      color: ThemeColors.fontWhite)),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 6.h),
                                child: Divider(
                                    thickness: 1.w,
                                    color: ThemeColors.borderDark),
                              ),
                              SpacedColumn(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InputLabel(label: 'User Name'),
                                    if (state.apiState.userMe.name != null)
                                      PostCreateInput(
                                        maxlines: 1,
                                        validator: Validator.validateText,
                                        controller: userName,
                                      ),
                                    if (pwErrorTextName != null)
                                      SizedText(
                                        text: pwErrorTextName,
                                        textAlign: TextAlign.center,
                                        textStyle: latoM14.copyWith(
                                            color: ThemeColors.red400),
                                      ),
                                    Row(
                                      children: [
                                        Checkbox(
                                          splashRadius: 0,
                                          shape: const CircleBorder(),
                                          checkColor: ThemeColors.black,
                                          activeColor: ThemeColors.yellow,
                                          fillColor: MaterialStateProperty
                                              .resolveWith<Color>(
                                                  (Set<MaterialState> states) {
                                            if (states.contains(
                                                MaterialState.focused)) {
                                              return ThemeColors.fontWhite;
                                            } else {
                                              return ThemeColors.yellow;
                                            }
                                          }),
                                          value: isPwChange,
                                          onChanged: (value) {
                                            setState(() {
                                              isPwChange = value!;
                                            });
                                          },
                                        ),
                                        SizedText(
                                            textAlign: TextAlign.start,
                                            width: 260.w,
                                            text: 'Change password',
                                            textStyle: latoM20.copyWith(
                                                color: isPwChange
                                                    ? ThemeColors.fontWhite
                                                    : ThemeColors.borderDark)),
                                      ],
                                    ),
                                  ]),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
                      if (isPwChange)
                        DefaultBanner(
                          bgColor: ThemeColors.black,
                          child: Container(
                            padding: EdgeInsets.all(12.w),
                            child: SpacedColumn(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedText(
                                    text: 'Password',
                                    textStyle: latoR14.copyWith(
                                        color: ThemeColors.fontWhite)),
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 6.h),
                                  child: Divider(
                                      thickness: 1.w,
                                      color: ThemeColors.borderDark),
                                ),
                                SpacedColumn(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      InputLabel(label: 'Current Password'),
                                      PostCreateInput(
                                        isObscured: true,
                                        maxlines: 1,
                                        // validator: Validator.validatePassword,
                                        controller: currentPass,
                                      ),
                                      if (pwErrorTextCurr != null)
                                        SizedText(
                                          text: pwErrorTextCurr,
                                          textAlign: TextAlign.center,
                                          textStyle: latoM14.copyWith(
                                              color: ThemeColors.red400),
                                        ),
                                      SizedBox(
                                        height: 25.h,
                                      ),
                                      InputLabel(label: 'New Password'),
                                      PostCreateInput(
                                        isObscured: true,
                                        maxlines: 1,
                                        validator: Validator.validatePassword,
                                        controller: newPass,
                                      ),
                                      SizedBox(
                                        height: 25.h,
                                      ),
                                      InputLabel(label: 'Confirm Password'),
                                      PostCreateInput(
                                        isObscured: true,
                                        maxlines: 1,
                                        // validator: Validator.validatePassword,
                                        controller: confirmNewPass,
                                      ),
                                    ]),
                                if (pwErrorText != null)
                                  SizedText(
                                    text: pwErrorText,
                                    textAlign: TextAlign.center,
                                    textStyle: latoM14.copyWith(
                                        color: ThemeColors.red400),
                                  )
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            footer: ExpandedButton(
              text: 'Save',
              onPressed: () {
                if (_formKeyEditProfilePage.currentState!.validate()) {
                  _validateConfirmNumber(currentPass.text, newPass.text,
                      confirmNewPass.text, state.apiState.userMe.password!);
                }
              },
            ),
          );
        });
  }

  _onUpdateUser({bool onlyNameChange = true}) async {
    if (onlyNameChange) {
      //Check if new username and old usernmae is same
      if (appStore.state.apiState.userMe.name == userName.text) {
        setState(() {
          pwErrorTextName = 'Name is same as before!';
        });
      } else {
        appStore.dispatch(GetChangeUserInfoAction(username: userName.text));
      }
    } else {
      appStore.dispatch(GetChangeUserInfoAction(
          newPass: newPass.text, username: userName.text));
    }
  }

  Widget _buildTitleIcon() {
    return IconButton(
      padding: EdgeInsets.zero,
      iconSize: 25.w,
      icon: const Icon(Ionicons.chevron_back_outline),
      onPressed: () {
        appStore.dispatch(NavigateToAction(to: 'up'));
      },
    );
  }

  _validateConfirmNumber(String currentPass, String newPasss,
      String confirmNewPasss, String oldPass) {
    if (isPwChange) {
      if (newPasss != confirmNewPasss) {
        setState(() {
          pwErrorText = 'Password did not match';
        });
      } else {
        setState(() {
          pwErrorText = null;
        });
        if (encryptToken(currentPass) == oldPass) {
          setState(() {
            pwErrorTextCurr = null;
          });
          _onUpdateUser(onlyNameChange: false);
          //TODO: Continue editing pass
        } else {
          setState(() {
            pwErrorTextCurr =
                'The current password does not match with old password!';
          });
        }
      }
    } else {
      _onUpdateUser();
    }
  }
}
