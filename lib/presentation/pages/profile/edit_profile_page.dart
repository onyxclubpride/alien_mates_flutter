import 'dart:io';
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

  @override
  void dispose() {
    userName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) {
          userName = TextEditingController(text: state.apiState.userMe.name);
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
                                    SizedBox(
                                      height: 25.h,
                                    ),
                                  ]),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InputLabel(label: 'Current Password'),
                                    PostCreateInput(
                                      isObscured: true,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      maxlines: 1,
                                      validator: Validator.validatePassword,
                                      controller: currentPass,
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
                                      controller: confirmNewPass,
                                    ),
                                  ]),
                              // if (pwErrorText != null)
                              SizedText(
                                text: pwErrorText,
                                textAlign: TextAlign.center,
                                textStyle:
                                    latoM14.copyWith(color: ThemeColors.red400),
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
                _validateConfirmNumber(newPass, confirmNewPass);
                // _onUpdateEvent(state.apiState.postDetail.postId);
              },
            ),
          );
        });
  }

  _onUpdateUser(String postId) async {}

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

  _validateConfirmNumber(newPass, confirmNewPass) {
    if (newPass != confirmNewPass) {
      setState(() {
        pwErrorText = 'Password did not match';
      });
      return false;
    } else {
      setState(() {
        pwErrorText = null;
      });
      return true;
    }
  }
}
