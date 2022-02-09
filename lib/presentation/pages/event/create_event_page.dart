import 'dart:io';

import 'package:alien_mates/mgr/navigation/app_routes.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:alien_mates/mgr/redux/action.dart';
import 'package:alien_mates/presentation/template/base/template.dart';
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
  TextEditingController maxPplController = TextEditingController(text: "");
  TextEditingController locationController = TextEditingController(text: "");

  File? postImage;

  bool agreementChecked = false;

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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: ThemeColors.borderDark),
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.r))),
                      child: Padding(
                        padding: EdgeInsets.all(10.h),
                        child: SpacedColumn(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedText(
                                text: 'Event details',
                                textStyle: latoR14.copyWith(
                                    color: ThemeColors.fontWhite)),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Divider(
                                  thickness: 1.w,
                                  color: ThemeColors.borderDark),
                            ),
                            InputLabel(label: 'Title'),
                            PostCreateInput(
                              controller: titleController,
                              validator: Validator.validateTitle,
                            ),
                            SizedBox(height: 20.h),
                            InputLabel(label: 'Description'),
                            PostCreateInput(
                              keyboardType: TextInputType.multiline,
                              maxlines: 10,
                              textInputAction: TextInputAction.newline,
                              hintText: 'Add description about an event!',
                              controller: descriptionController,
                              validator: Validator.validateDescription,
                            ),
                            SizedBox(height: 20.h),
                            InputLabel(label: 'Maximum people'),
                            PostCreateInput(
                              validator: Validator.validateMaxPeople,
                              hintText:
                                  'Leave the field empty if the # of people is 0',
                              controller: maxPplController,
                              keyboardType: TextInputType.number,
                            ),
                            SizedBox(height: 20.h),
                            InputLabel(label: 'Location'),
                            PostCreateInput(
                              hintText: 'Add the Location',
                              controller: locationController,
                            ),
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
                              ? Column(
                                  children: [
                                    const Icon(
                                      Ionicons.add,
                                      size: 120,
                                      color: ThemeColors.coolgray600,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10.0),
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
                    SpacedRow(
                      children: [
                        Checkbox(
                          splashRadius: 0,
                          shape: const CircleBorder(),
                          checkColor: ThemeColors.black,
                          activeColor: ThemeColors.yellow,
                          fillColor: MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                            if (states.contains(MaterialState.focused)) {
                              return ThemeColors.fontWhite;
                            } else {
                              return ThemeColors.yellow;
                            }
                          }),
                          value: agreementChecked,
                          onChanged: (value) {
                            setState(() {
                              agreementChecked = value!;
                            });
                          },
                        ),
                        SpacedColumn(
                          children: [
                            SizedText(
                                textAlign: TextAlign.start,
                                width: 260.w,
                                text: 'Phone number usage agreement!',
                                textStyle: latoM20.copyWith(
                                    color: agreementChecked
                                        ? ThemeColors.fontWhite
                                        : ThemeColors.borderDark)),
                            if (!agreementChecked)
                              SizedText(
                                  textAlign: TextAlign.start,
                                  width: 260.w,
                                  text:
                                      '* REQUIRED! Your phone number will be visible in the event details to let others contact you about the event information!',
                                  textStyle:
                                      latoR14.copyWith(color: ThemeColors.red)),
                          ],
                        ),
                      ],
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
      if (agreementChecked) {
        bool created = await appStore.dispatch(GetCreateEventAction(
            title: titleController.text,
            description: descriptionController.text,
            eventLocation: locationController.text,
            joinLimit: int.tryParse(maxPplController.text),
            imagePath: postImage?.path));

        if (!created) {
          showAlertDialog(context,
              text:
                  'There was a problem while uploading to server! Please, try again!');
        } else {
          appStore.dispatch(NavigateToAction(to: 'up'));
        }
      } else {
        showAlertDialog(context,
            text: 'Please, check the agreement box to continue!');
      }
    }
  }

  _buildDesc() {
    return Flexible(
      child: Form(
        key: _formKeyCreateEventPage,
        child: PostCreateInput(
          keyboardType: TextInputType.multiline,
          maxlines: 10,
          textInputAction: null,
          hintText: 'Add description about post!',
          controller: descriptionController,
          validator: Validator.validateDescription,
        ),
      ),
    );
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
