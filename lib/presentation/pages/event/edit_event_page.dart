import 'dart:io';

import 'package:alien_mates/mgr/redux/states/api_state.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:alien_mates/mgr/redux/action.dart';
import 'package:alien_mates/presentation/template/base/template.dart';
import 'package:ionicons/ionicons.dart';

class EditEventPage extends StatefulWidget {
  bool? isNotice;

  EditEventPage({this.isNotice});

  @override
  State<EditEventPage> createState() => _EditEventPageState();
}

class _EditEventPageState extends State<EditEventPage> {
  final GlobalKey<FormState> _formKeyEditEventPage =
      GlobalKey<FormState>(debugLabel: '_formKeyEditEventPage');

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController maxPplController = TextEditingController(text: "0");
  TextEditingController locationController = TextEditingController();

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
          maxPplController = TextEditingController(
              text: state.apiState.postDetail.joinLimit.toString());
          locationController = TextEditingController(
              text: state.apiState.postDetail.eventLocation);
          return DefaultBody(
            withNavigationBar: false,
            withTopBanner: false,
            withActionButton: false,
            titleIcon: _buildTitleIcon(),
            titleText:
                SizedText(text: 'Edit Event details', textStyle: latoM20),
            child: Form(
              key: _formKeyEditEventPage,
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
                                text: 'Edit Event details',
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
                                      validator: Validator.validateTitle,
                                    ),
                                  ]),
                              SpacedColumn(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InputLabel(label: 'Description'),
                                    PostCreateInput(
                                      hintText:
                                          'Add you KakaoTalk or contact number to let them contact you..  ',
                                      maxlines: 10,
                                      validator: Validator.validateDescription,
                                      controller: descriptionController,
                                    ),
                                  ]),
                              SpacedColumn(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InputLabel(label: 'Maximum people'),
                                    PostCreateInput(
                                      hintText: 'Leave 0 if none',
                                      controller: maxPplController,
                                      validator: Validator.validateMaxPeople,
                                      keyboardType: TextInputType.number,
                                    ),
                                  ]),
                              SpacedColumn(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InputLabel(label: 'Location'),
                                    PostCreateInput(
                                      hintText: 'Add the Location',
                                      validator: Validator.validateText,
                                      controller: locationController,
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
    if (_formKeyEditEventPage.currentState!.validate()) {
      bool created = await appStore.dispatch(GetUpdatePostAction(
          title: titleController.text,
          description: descriptionController.text,
          joinLimit: int.parse(maxPplController.text),
          eventLocation: locationController.text,
          imagePath: noticeImage?.path,
          showloading: true,
          postId: postId));

      if (!created) {
        showAlertDialog(context,
            text:
                'There was a problem while updating to server! Please, try again!');
      } else {
        appStore.dispatch(GetFetchMorePostsAction(isEventOnly: true));
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
