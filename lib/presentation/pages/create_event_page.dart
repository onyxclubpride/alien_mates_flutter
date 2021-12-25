import 'dart:io';

import 'package:alien_mates/mgr/models/model_exporter.dart';
import 'package:alien_mates/mgr/navigation/app_routes.dart';
import 'package:alien_mates/presentation/widgets/input/input_label.dart';
import 'package:alien_mates/presentation/widgets/input/post_create_input.dart';
import 'package:alien_mates/presentation/widgets/show_alert_dialog.dart';
import 'package:alien_mates/utils/common/log_tester.dart';
import 'package:alien_mates/utils/common/validators.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:alien_mates/mgr/redux/action.dart';
import 'package:alien_mates/presentation/template/base/template.dart';
import 'package:flutter/material.dart';
import 'package:alien_mates/mgr/redux/app_state.dart';
import 'package:alien_mates/presentation/widgets/button/expanded_btn.dart';
import 'package:alien_mates/presentation/widgets/input/basic_input.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';

class CreateEventPage extends StatefulWidget {
  @override
  State<CreateEventPage> createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  final GlobalKey<FormState> _formKeyCreateEventPage =
      GlobalKey<FormState>(debugLabel: '_formKeyCreateEventPage');

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController maxPplController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  File? postImage;

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    maxPplController.dispose();
    locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) {
          return DefaultBody(
            withNavigationBar: false,
            withTopBanner: false,
            withActionButton: false,
            titleIcon: _buildTitleIcon(),
            titleText:
                SizedText(text: 'Create an Event post', textStyle: latoM20),
            child: Form(
              key: _formKeyCreateEventPage,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    DefaultBanner(
                      bgColor: ThemeColors.black,
                      child: Container(
                        padding: EdgeInsets.all(12.w),
                        child: SpacedColumn(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedText(
                                text: 'Event details',
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
                              SpacedColumn(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InputLabel(label: 'Maximum people'),
                                    PostCreateInput(
                                      controller: maxPplController,
                                      keyboardType: TextInputType.number,
                                      validator: Validator.validateNumber,
                                    ),
                                  ]),
                              SpacedColumn(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InputLabel(label: 'Location'),
                                    PostCreateInput(
                                      controller: locationController,
                                      validator: Validator.validateText,
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
                          child: postImage == null
                              ? const Icon(
                                  Ionicons.add,
                                  color: ThemeColors.borderDark,
                                )
                              : Image.file(postImage!)),
                    ),
                    SizedBox(height: 20.h),
                    ExpandedButton(text: 'Post', onPressed: _onPostEvent),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          );
        });
  }

  _onChooseImage() async {
    String? xImagePath = await appStore.dispatch(GetSelectImageAction());
    if (xImagePath != null) {
      setState(() {
        postImage = File(xImagePath);
      });
    }
  }

  _onPostEvent() async {
    if (_formKeyCreateEventPage.currentState!.validate()) {
      bool created = await appStore.dispatch(GetCreateEventAction(
          title: titleController.text,
          description: descriptionController.text,
          eventLocation: locationController.text,
          joinLimit: int.parse(maxPplController.text),
          imagePath: postImage?.path));

      if (!created) {
        showAlertDialog(context,
            text:
                'There was a problem while uploading to server! Please, try again!');
      } else {
        appStore.dispatch(NavigateToAction(to: AppRoutes.eventsPageRoute));
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
