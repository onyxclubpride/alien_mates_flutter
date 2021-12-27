import 'dart:io';

import 'package:alien_mates/mgr/models/model_exporter.dart';
import 'package:alien_mates/mgr/navigation/app_routes.dart';
import 'package:alien_mates/mgr/redux/states/api_state.dart';
import 'package:alien_mates/presentation/widgets/input/input_label.dart';
import 'package:alien_mates/presentation/widgets/input/post_create_input.dart';
import 'package:alien_mates/presentation/widgets/show_alert_dialog.dart';
import 'package:alien_mates/utils/common/log_tester.dart';
import 'package:alien_mates/utils/common/validators.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:alien_mates/mgr/redux/action.dart';
import 'package:alien_mates/presentation/template/base/template.dart';
import 'package:flutter/material.dart';
import 'package:alien_mates/mgr/redux/app_state.dart';
import 'package:alien_mates/presentation/widgets/button/expanded_btn.dart';
import 'package:alien_mates/presentation/widgets/input/basic_input.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';

class EditNoticePage extends StatefulWidget {
  bool? isNotice;

  EditNoticePage({this.isNotice});

  @override
  State<EditNoticePage> createState() => _EditNoticePageState();
}

class _EditNoticePageState extends State<EditNoticePage> {
  final GlobalKey<FormState> _formKeyEditNoticePage =
      GlobalKey<FormState>(debugLabel: '_formKeyEditNoticePage');

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  File? noticeImage;

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) {
          titleController =
              TextEditingController(text: state.apiState.postDetail.title);
          descriptionController = TextEditingController(
              text: state.apiState.postDetail.description);
          return DefaultBody(
            withNavigationBar: false,
            withTopBanner: false,
            withActionButton: false,
            titleIcon: _buildTitleIcon(),
            titleText:
                SizedText(text: 'Edit Notice details', textStyle: latoM20),
            child: Form(
              key: _formKeyEditNoticePage,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DefaultBanner(
                      bgColor: ThemeColors.black,
                      child: Container(
                        padding: EdgeInsets.all(12.w),
                        child: SpacedColumn(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedText(
                                text: 'Notice details',
                                textStyle: latoR14.copyWith(
                                    color: ThemeColors.fontWhite)),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 6.h),
                              child: Divider(
                                  thickness: 1.w,
                                  color: ThemeColors.borderDark),
                            ),
                            SpacedColumn(verticalSpace: 12.h, children: [
                              SpacedColumn(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InputLabel(label: 'Title'),
                                    PostCreateInput(
                                      controller: titleController,
                                      validator: Validator.validateText,
                                    ),
                                  ]),
                              SpacedColumn(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InputLabel(label: 'Description'),
                                    PostCreateInput(
                                      maxlines: 10,
                                      validator: Validator.validateText,
                                      controller: descriptionController,
                                    ),
                                  ]),
                            ]),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    DefaultBanner(
                      onTap: _onChooseImage,
                      height: 200.h,
                      child: FittedBox(
                          child: _getImageOrNotWidget(state.apiState)),
                    ),
                    SizedBox(height: 40.h),
                    ExpandedButton(
                      text: 'Save',
                      onPressed: () {
                        _onUpdateEvent(state.apiState.postDetail.postId);
                      },
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
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
    if (_formKeyEditNoticePage.currentState!.validate()) {
      bool created = await appStore.dispatch(GetUpdatePostAction(
          title: titleController.text,
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
