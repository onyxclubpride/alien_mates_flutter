import 'package:alien_mates/mgr/navigation/app_routes.dart';
import 'package:alien_mates/mgr/redux/action.dart';
import 'package:alien_mates/presentation/template/base/template.dart';
import 'package:alien_mates/presentation/widgets/button/expanded_btn.dart';
import 'package:alien_mates/presentation/widgets/input/post_create_input.dart';
import 'package:alien_mates/presentation/widgets/show_alert_dialog.dart';
import 'package:alien_mates/utils/common/validators.dart';
import 'package:flutter_redux/flutter_redux.dart';

class Fab2 extends StatelessWidget {
  String? contractType;

  final GlobalKey<FormState> _formKeyCreatePostPage =
      GlobalKey<FormState>(debugLabel: '_formKeyCreatePostPage');

  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) => Scaffold(
              floatingActionButton: FloatingActionButton(onPressed: () {
                _onEditPress(context);
              }),
            ));
  }

  _onEditPress(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: ThemeColors.bgDark,
        enableDrag: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r))),
        context: context,
        barrierColor: ThemeColors.black.withOpacity(0.8),
        isScrollControlled: true,
        builder: (context) {
          return Container(
            height: 300.h,
            margin: EdgeInsets.all(25.w),
            child: SpacedColumn(children: [
              SizedBox(height: 0.h),
              GestureDetector(
                onTap: () {
                  appStore.dispatch(DismissPopupAction());
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.r),
                  child: Container(
                    width: 80.w,
                    height: 4.h,
                    color: ThemeColors.gray1,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              ExpandedButton(
                text: 'Feed',
                onPressed: _onFeedPress(context),
              ),
              SizedBox(height: 27.h),
              ExpandedButton(
                text: 'Event',
                onPressed: () {
                  appStore.dispatch(
                      NavigateToAction(to: AppRoutes.createEventPageRoute));
                },
              ),
              SizedBox(height: 27.h),
              ExpandedButton(
                text: 'Support',
                onPressed: () {
                  appStore.dispatch(
                      NavigateToAction(to: AppRoutes.createHelpPageRoute));
                },
              ),
              SizedBox(height: 27.h),
              ExpandedButton(
                text: 'Notice',
                onPressed: () {
                  appStore.dispatch(
                      NavigateToAction(to: AppRoutes.createNoticePageRoute));
                },
              ),
            ]),
          );
        });
    // appStore.dispatch(NavigateToAction(to: AppRoutes.createHelpPageRoute));
  }

  _onFeedPress(BuildContext context) {
    appStore.dispatch(DismissPopupAction());
    showModalBottomSheet(
        backgroundColor: ThemeColors.bgDark,
        enableDrag: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r))),
        context: context,
        barrierColor: ThemeColors.black.withOpacity(0.8),
        isScrollControlled: true,
        builder: (context) {
          return Container(
            height: 150.h,
            margin: EdgeInsets.all(25.w),
            child: SpacedColumn(children: [
              SizedBox(height: 0.h),
              GestureDetector(
                onTap: () {
                  appStore.dispatch(DismissPopupAction());
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.r),
                  child: Container(
                    width: 80.w,
                    height: 4.h,
                    color: ThemeColors.gray1,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              ExpandedButton(
                text: 'Image only',
                onPressed: _onImageOnlyPress(context),
              ),
              SizedBox(height: 27.h),
              ExpandedButton(
                text: 'Text only',
                onPressed: _onTextOnlyPress(context),
              ),
            ]),
          );
        });
  }

  _onImageOnlyPress(BuildContext context) {
    appStore.dispatch(DismissPopupAction());
    showModalBottomSheet(
        backgroundColor: ThemeColors.bgDark,
        enableDrag: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r))),
        context: context,
        barrierColor: ThemeColors.black.withOpacity(0.8),
        isScrollControlled: true,
        builder: (context) {
          return ImagesContainerForSheet();
        });
  }

  _onTextOnlyPress(BuildContext context) {
    appStore.dispatch(DismissPopupAction());
    showModalBottomSheet(
        backgroundColor: ThemeColors.bgDark,
        enableDrag: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r))),
        context: context,
        barrierColor: ThemeColors.black.withOpacity(0.8),
        isScrollControlled: true,
        builder: (context) {
          return Container(
            height: 360.h + MediaQuery.of(context).viewInsets.bottom,
            margin: EdgeInsets.symmetric(horizontal: 25.w),
            child: Column(children: [
              // if (MediaQuery.of(context).viewInsets.bottom == 0)
              SizedBox(height: 15.h),
              if (MediaQuery.of(context).viewInsets.bottom == 0)
                GestureDetector(
                  onTap: () {
                    appStore.dispatch(DismissPopupAction());
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.r),
                    child: Container(
                      width: 80.w,
                      height: 4.h,
                      color: ThemeColors.gray1,
                    ),
                  ),
                ),
              SizedBox(height: 10.h),
              SizedText(
                  text: "Create Post",
                  textStyle: latoM30.copyWith(color: ThemeColors.fontDark)),
              SizedBox(height: 10.h),
              Divider(thickness: 1.w, color: ThemeColors.borderDark),
              SizedBox(height: 10.h),
              Form(
                key: _formKeyCreatePostPage,
                child: PostCreateInput(
                  maxlines: 10,
                  hintText: 'Type something...',
                  validator: Validator.validateText,
                  controller: descriptionController,
                ),
              ),
              SizedBox(height: 30.h),
              ExpandedButton(
                text: 'POST',
                onPressed: _onPostPost(context),
              ),
            ]),
          );
        });
  }

  _onPostPost(BuildContext context) async {
    if (_formKeyCreatePostPage.currentState!.validate()) {
      bool created = await appStore.dispatch(
          GetCreatePostAction(description: descriptionController.text));
      if (!created) {
        showAlertDialog(context,
            text:
                'There was a problem while uploading to server! Please, try again!');
      } else {
        appStore.dispatch(NavigateToAction(to: AppRoutes.homePageRoute));
      }
    }
  }
}
