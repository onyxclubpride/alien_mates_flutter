import 'dart:io';
import 'package:alien_mates/presentation/widgets/button/expanded_btn.dart';
import 'package:alien_mates/presentation/widgets/cached_image_or_text_widget.dart';
import 'package:alien_mates/presentation/widgets/input/input_label.dart';
import 'package:alien_mates/presentation/widgets/input/post_create_input.dart';
import 'package:alien_mates/presentation/widgets/show_alert_dialog.dart';
import 'package:alien_mates/presentation/widgets/show_body_dialog.dart';
import 'package:alien_mates/utils/common/log_tester.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ionicons/ionicons.dart';
import 'package:alien_mates/mgr/models/model_exporter.dart';
import 'package:alien_mates/mgr/navigation/app_routes.dart';
import 'package:alien_mates/mgr/redux/action.dart';
import 'package:alien_mates/mgr/redux/states/api_state.dart';
import 'package:alien_mates/presentation/template/base/template.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ScrollController _controller = ScrollController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) => DefaultBody(
            withTopBanner: false,
            withNavigationBar: false,
            // showFloatingButton: true, // Need to fix it
            rightIcon: Ionicons.create_outline,
            titleText: SizedText(
              text: "Back",
              textStyle: latoM20,
            ),
            titleIcon: _buildTitleIcon(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildUserInfoWidget(state.apiState),
                SizedBox(height: 20.h),
                Divider(thickness: 1.w, color: ThemeColors.borderDark),
                SizedBox(height: 10.h),
                SizedText(
                    text: "My Feed",
                    textStyle: latoM25.copyWith(color: ThemeColors.fontDark)),
                SizedBox(height: 10.h),
                SizedBox(
                  height: 290.h,
                  child: ListView(
                    shrinkWrap: true,
                    controller: _controller,
                    children: [..._buildPostsWidgetList(state)],
                  ),
                )
              ],
            )));
  }

  Widget _buildUserInfoWidget(ApiState state) {
    UserModelRes userModelRes = state.userMe;
    return DefaultBanner(
      height: 140.h,
      child: Padding(
        padding: EdgeInsets.all(15.w),
        child: SpacedColumn(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildUserInfoItem(valueText: userModelRes.name),
            _buildUserInfoItem(
                icon: Ionicons.chatbox, valueText: userModelRes.uniName),
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
      horizontalSpace: 10.w,
      children: [
        Icon(icon, color: ThemeColors.fontDark, size: 25.w),
        SizedText(
            text: valueText,
            textStyle: latoM16.copyWith(color: ThemeColors.fontDark)),
      ],
    );
  }

  List<Widget> _buildPostsWidgetList(AppState state) {
    List<Widget> _list = [];
    List<ListPostModelRes> postsList = state.apiState.posts;
    logger(state.apiState.userMe.postIds, hint: 'USER POST IDS');
    for (int i = 0; i < postsList.length; i++) {
      ListPostModelRes _item = postsList[i];
      if (state.apiState.userMe.postIds!.contains(_item.postId)) {
        _list.add(PostItemBanner(
            height: 110.h,
            imageUrl: _item.imageUrl,
            leftWidget: InkWell(
              onTap: () {
                _onDeletePress(_item.postId);
              },
              child: const SizedText(
                text: 'Delete',
              ),
            ),
            rightWidget: InkWell(
              onTap: () {
                _onEditPostPress(_item.postId);
              },
              child: const SizedText(
                text: 'Edit',
              ),
            ),
            child: CachedImageOrTextImageWidget(
                title: _item.title,
                maxLines: 3,
                imageUrl: _item.imageUrl,
                description: _item.description)));
      }
    }
    return _list;
  }

  Widget _buildTitleIcon() {
    return IconButton(
      padding: EdgeInsets.zero,
      iconSize: 30.w,
      icon: const Icon(Ionicons.chevron_back_outline),
      onPressed: () {
        appStore.dispatch(NavigateToAction(to: 'up'));
      },
    );
  }

  _onEditPostPress(String postId) async {
    appStore.dispatch(
        GetPostByIdAction(postId, goToRoute: AppRoutes.editNoticePageRoute));
  }

  _onDeletePress(String postId) {
    showBodyDialog(
      context,
      text: 'Do you want to delete?',
      onMainButtonText: 'Yes',
      onPress: () {
        appStore.dispatch(GetDeletePostAction(postId));
      },
    );
  }
}

class ImagesContainerForSheet extends StatefulWidget {
  const ImagesContainerForSheet({Key? key}) : super(key: key);

  @override
  _ImagesContainerForSheetState createState() =>
      _ImagesContainerForSheetState();
}

class _ImagesContainerForSheetState extends State<ImagesContainerForSheet> {
  File? postImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350.h,
      margin: EdgeInsets.all(25.w),
      child: SpacedColumn(children: [
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
        DefaultBanner(
          onTap: _onChooseImage,
          height: 200.h,
          child: FittedBox(
              child: postImage == null
                  ? const Icon(
                      Ionicons.add,
                      color: ThemeColors.borderDark,
                    )
                  : Image.file(postImage!)),
        ),
        SizedBox(height: 20.h),
        ExpandedButton(
          text: 'POST',
          onPressed: _onPostPost,
        ),
      ]),
    );
  }

  _onChooseImage() async {
    String? xImagePath = await appStore.dispatch(GetSelectImageAction());
    if (xImagePath != null) {
      setState(() {
        postImage = File(xImagePath);
      });
    }
  }

  _onPostPost() async {
    if (postImage != null) {
      bool created = await appStore
          .dispatch(GetCreatePostAction(imagePath: postImage?.path));

      if (!created) {
        showAlertDialog(context,
            text:
                'There was a problem while uploading to server! Please, try again!');
      } else {
        appStore.dispatch(NavigateToAction(to: AppRoutes.homePageRoute));
      }
    } else {
      showAlertDialog(context, text: 'Please select image first!');
    }
  }
}
