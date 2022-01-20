import 'dart:io';

import 'package:alien_mates/mgr/redux/states/api_state.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:alien_mates/mgr/redux/action.dart';
import 'package:alien_mates/presentation/template/base/template.dart';
import 'package:ionicons/ionicons.dart';

class EditPostPage extends StatefulWidget {
  @override
  State<EditPostPage> createState() => _EditPostPageState();
}

class _EditPostPageState extends State<EditPostPage> {
  final GlobalKey<FormState> _formKeyEditPostPage =
      GlobalKey<FormState>(debugLabel: '_formKeyEditPostPage');

  TextEditingController descriptionController = TextEditingController();

  File? noticeImage;

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) {
          descriptionController = TextEditingController(
              text: state.apiState.postDetail.description);
          return DefaultBody(
            withNavigationBar: false,
            withTopBanner: false,
            withActionButton: false,
            titleIcon: _buildTitleIcon(),
            titleText: SizedText(text: 'Edit Post details', textStyle: latoM20),
            child: Form(
              key: _formKeyEditPostPage,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // if (descriptionController.text.isNotEmpty)
                    DefaultBanner(
                      bgColor: ThemeColors.black,
                      child: Container(
                        padding: EdgeInsets.all(12.w),
                        child: SpacedColumn(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedText(
                                text: 'Post details',
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
                                  if (state.apiState.postDetail.description !=
                                      null)
                                    InputLabel(label: 'Description'),
                                  if (state.apiState.postDetail.description !=
                                      null)
                                    PostCreateInput(
                                      maxlines: 10,
                                      validator: Validator.validateText,
                                      controller: descriptionController,
                                    ),
                                  if (state.apiState.postDetail.imageUrl !=
                                      null)
                                    InputLabel(label: '  Tap on Image'),
                                  if (state.apiState.postDetail.imageUrl !=
                                      null)
                                    DefaultBanner(
                                      onTap: _onChooseImage,
                                      height: 200.h,
                                      child: FittedBox(
                                          child: _getImageOrNotWidget(
                                              state.apiState)),
                                    ),
                                ]),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            footer: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: ExpandedButton(
                text: 'Save',
                onPressed: () {
                  _onUpdateEvent(state.apiState.postDetail.postId);
                },
              ),
            ),
          );
        });
  }

  Widget _getImageOrNotWidget(ApiState state) {
    if (noticeImage != null) {
      return Image.file(noticeImage!, fit: BoxFit.fitHeight);
    }
    if (state.postDetail.imageUrl != null) {
      return CachedNetworkImage(
          imageUrl: state.postDetail.imageUrl!, fit: BoxFit.fitHeight);
    }
    return const Icon(Ionicons.add, color: ThemeColors.borderDark);
  }

  _onChooseImage() async {
    String? xImagePath = await appStore.dispatch(GetSelectImageAction());
    if (xImagePath != null) {
      setState(() {
        noticeImage = File(xImagePath);
      });
    }
  }

  _onUpdateEvent(String postId) async {
    if (_formKeyEditPostPage.currentState!.validate()) {
      bool created = await appStore.dispatch(GetUpdatePostAction(
          description: descriptionController.text,
          imagePath: noticeImage?.path,
          postId: postId));

      if (!created) {
        showAlertDialog(context,
            text:
                'There was a problem while updating to server! Please, try again!');
      } else {
        appStore.dispatch(NavigateToAction(to: 'up'));
      }
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
}
