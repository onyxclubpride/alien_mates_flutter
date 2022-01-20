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
                                      regexPattern: RegExp(r'^[0-9]*$'),
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
                            SizedText(
                                textAlign: TextAlign.start,
                                width: 260.w,
                                text:
                                    '* Edit to show agreement to show the phone number of the user',
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
            joinLimit: int.parse(maxPplController.text).toInt(),
            imagePath: postImage?.path));

        if (!created) {
          showAlertDialog(context,
              text:
                  'There was a problem while uploading to server! Please, try again!');
        } else {
          appStore.dispatch(NavigateToAction(to: AppRoutes.eventsPageRoute));
        }
      } else {
        showAlertDialog(context,
            text: 'Please, check the agreement box to continue!');
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
