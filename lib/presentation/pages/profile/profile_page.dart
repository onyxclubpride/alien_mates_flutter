import 'dart:io';
import 'package:alien_mates/presentation/layout/profile_layout.dart';
import 'package:alien_mates/presentation/widgets/cached_image_or_text_widget.dart';
import 'package:alien_mates/presentation/widgets/show_body_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ionicons/ionicons.dart';
import 'package:alien_mates/mgr/models/model_exporter.dart';
import 'package:alien_mates/mgr/navigation/app_routes.dart';
import 'package:alien_mates/mgr/redux/action.dart';
import 'package:alien_mates/presentation/template/base/template.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ProfileLayout(buildWidget: _buildPostsWidgetList);
  }

  PostModelRes _getPostModel(snapshot) {
    final _postDetail = snapshot;
    PostModelRes _postModelRes = PostModelRes(
        createdDate: _postDetail['createdDate'],
        postId: _postDetail['postId'],
        isNotice: _postDetail['isNotice'],
        isPost: _postDetail['isPost'],
        userId: _postDetail['userId'],
        isEvent: _postDetail['isEvent'],
        isHelp: _postDetail['isHelp'],
        likedUserIds: _postDetail['likedUserIds'],
        joinedUserIds: _postDetail['joinedUserIds'],
        description: _postDetail['description'],
        title: _postDetail['title'],
        joinLimit: _postDetail['joinLimit'],
        imageUrl: _postDetail['imageUrl'],
        eventLocation: _postDetail['eventLocation']);
    return _postModelRes;
  }

  Widget _buildPostsWidgetList(BuildContext ctx,
      List<DocumentSnapshot> snapshots, int index, AppState state) {
    final _item = _getPostModel(snapshots[index]);

    return PostItemBanner(
      height: 130.h,
      imageUrl: _item.imageUrl,
      desc: _item.description,
      leftWidget: InkWell(
        onTap: () {
          _onDeletePress(_item.postId);
        },
        child: SizedText(
          text: 'Delete',
          textStyle: latoR14.copyWith(color: ThemeColors.coolgray300),
        ),
      ),
      rightWidget: InkWell(
        onTap: () {
          _onEditPostPress(_item);
        },
        child: SizedText(
          text: 'Edit',
          textStyle: latoB14.copyWith(color: ThemeColors.coolgray300),
        ),
      ),
      child: CachedImageOrTextImageWidget(
          title: _item.title,
          maxLines: 3,
          imageUrl: _item.imageUrl,
          description: _item.description),
    );
  }

  _onEditPostPress(PostModelRes item) async {
    if (item.isNotice) {
      appStore.dispatch(GetPostByIdAction(item.postId,
          goToRoute: AppRoutes.editNoticePageRoute));
    }
    if (item.isEvent) {
      appStore.dispatch(GetPostByIdAction(item.postId,
          goToRoute: AppRoutes.editEventPageRoute));
    }
    if (item.isHelp) {
      appStore.dispatch(GetPostByIdAction(item.postId,
          goToRoute: AppRoutes.editHelpPageRoute));
    }
    if (item.isPost) {
      appStore.dispatch(GetPostByIdAction(item.postId,
          goToRoute: AppRoutes.editPostPageRoute));
    }
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
                  ? Column(
                      children: [
                        const Icon(
                          Ionicons.add,
                          size: 120,
                          color: ThemeColors.coolgray600,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: SizedText(
                            text: "Add images or GIF",
                            textStyle: latoR12.copyWith(
                                color: ThemeColors.coolgray500),
                          ),
                        ),
                      ],
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
        appStore.dispatch(NavigateToAction(to: 'up'));
      }
    } else {
      showAlertDialog(context, text: 'Please select image first!');
    }
  }
}
