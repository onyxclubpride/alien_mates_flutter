import 'package:alien_mates/mgr/models/model_exporter.dart';
import 'package:alien_mates/mgr/navigation/app_routes.dart';
import 'package:alien_mates/mgr/redux/action.dart';
import 'package:alien_mates/mgr/redux/middleware/api_middleware.dart';
import 'package:alien_mates/mgr/redux/states/api_state.dart';
import 'package:alien_mates/presentation/template/base/template.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ionicons/ionicons.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

class ProfileLayout extends StatefulWidget {
  Widget Function(BuildContext ctx, List<DocumentSnapshot<Object?>>, int index,
      AppState state) buildWidget;
  ProfileLayout({required this.buildWidget});

  @override
  State<ProfileLayout> createState() => _ProfileLayoutState();
}

class _ProfileLayoutState extends State<ProfileLayout> {
  final GlobalKey<FormState> _formKeyCreatePostPage =
      GlobalKey<FormState>(debugLabel: '_formKeyCreatePostPage');

  TextEditingController descriptionController = TextEditingController();
  final ScrollController _controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) => Scaffold(
              appBar: _getHeader(),
              floatingActionButton: FloatingActionButton(
                child: const Icon(Ionicons.add),
                backgroundColor: ThemeColors.bluegray700,
                onPressed: () {
                  _onEditPress(state);
                },
              ),
              body: PaginateFirestore(
                separator: SizedBox(height: 20.h),
                scrollController: _controller,
                itemBuilder: (_, documentSnapshots, index) {
                  return Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (index == 0)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildUserInfoWidget(state.apiState),
                                SizedBox(height: 10.h),
                                SizedText(
                                    text: "My Feed",
                                    textStyle: latoB25.copyWith(
                                        color: ThemeColors.fontDark)),
                                Divider(
                                    thickness: 1.w,
                                    color: ThemeColors.borderDark),
                                SizedBox(height: 20.h),
                              ],
                            ),
                        ],
                      ),
                      widget.buildWidget(_, documentSnapshots, index, state),
                    ],
                  );
                },
                physics: const BouncingScrollPhysics(),
                query: _getQuery(state),
                itemBuilderType: PaginateBuilderType.listView,
                isLive: true,
                padding: EdgeInsets.symmetric(horizontal: 12.w),
              ),
            ));
  }

  _getQuery(AppState state) {
    return postsCollection
        .orderBy('createdDate', descending: true)
        .where("userId", isEqualTo: state.apiState.userMe.userId)
        .limit(10);
  }

  _getHeader() {
    return DefaultHeader(
      rightIcon: Ionicons.settings_outline,
      withAction: true,
      onRightButtonClick: () {
        appStore.dispatch(GetExtraInfoAction());
        appStore.dispatch(NavigateToAction(to: AppRoutes.settingsPageRoute));
      },
      titleText: SizedText(text: "Back", textStyle: latoM20),
      titleIcon: _buildTitleIcon(),
    );
  }

  Widget _buildTitleIcon() {
    return IconButton(
        padding: EdgeInsets.zero,
        iconSize: 30.w,
        icon: const Icon(Ionicons.chevron_back_outline),
        onPressed: () {
          appStore.dispatch(NavigateToAction(to: 'up'));
        });
  }

  Widget _buildUserInfoWidget(ApiState state) {
    UserModelRes userModelRes = state.userMe;
    return DefaultBanner(
      // height: 150.h,
      child: Padding(
        padding: EdgeInsets.all(15.w),
        child: SpacedColumn(
          verticalSpace: 12.h,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildUserInfoItem(valueText: userModelRes.name),
            _buildUserInfoItem(
                icon: Ionicons.school, valueText: userModelRes.uniName),
            _buildUserInfoItem(
                icon: Ionicons.call, valueText: userModelRes.phoneNumber),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfoItem(
      {IconData icon = Ionicons.person, String? valueText = 'User134'}) {
    return SpacedRow(
      crossAxisAlignment: CrossAxisAlignment.center,
      horizontalSpace: 15.w,
      children: [
        Icon(icon, color: ThemeColors.fontDark, size: 25.w),
        SizedText(
            text: valueText,
            textStyle: latoM16.copyWith(color: ThemeColors.fontDark)),
      ],
    );
  }

  _onEditPress(AppState state) {
    showModalBottomSheet(
        backgroundColor: ThemeColors.componentBgDark,
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
            height: state.apiState.userMe.isAdmin == true ? 300.h : 240.h,
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
                onPressed: _onFeedPress,
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
              if (state.apiState.userMe.isAdmin == true)
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

  _onFeedPress() {
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
                onPressed: _onImageOnlyPress,
              ),
              SizedBox(height: 27.h),
              ExpandedButton(
                text: 'Text only',
                onPressed: _onTextOnlyPress,
              ),
            ]),
          );
        });
  }

  _onImageOnlyPress() {
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

  _onTextOnlyPress() {
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
              Flexible(
                child: Form(
                  key: _formKeyCreatePostPage,
                  child: PostCreateInput(
                    maxlines: 10,
                    hintText: 'What is going on today...? ⊙_0  \u200d👀 ',
                    validator: Validator.validateDescription,
                    controller: descriptionController,
                  ),
                ),
              ),
              SizedBox(height: 30.h),
              ExpandedButton(
                text: 'POST',
                onPressed: _onPostPost,
              ),
              SizedBox(height: 30.h),
            ]),
          );
        });
  }

  _onPostPost() async {
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
