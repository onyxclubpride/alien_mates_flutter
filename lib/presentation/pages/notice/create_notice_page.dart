import 'dart:io';

import 'package:alien_mates/utils/common/log_tester.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:alien_mates/mgr/redux/action.dart';
import 'package:alien_mates/presentation/template/base/template.dart';
import 'package:ionicons/ionicons.dart';

class CreateNoticePage extends StatefulWidget {
  bool? isNotice;

  CreateNoticePage({this.isNotice});

  @override
  State<CreateNoticePage> createState() => _CreateNoticePageState();
}

class _CreateNoticePageState extends State<CreateNoticePage> {
  final GlobalKey<FormState> _formKeyCreateNoticePage =
      GlobalKey<FormState>(debugLabel: '_formKeyCreateNoticePage');

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  File? helpImage;

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    logger(widget.isNotice, hint: 'ARGUMENT TEST');
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) {
          return DefaultBody(
            withNavigationBar: false,
            withTopBanner: false,
            withActionButton: false,
            titleIcon: _buildTitleIcon(),
            titleText:
                SizedText(text: 'Create a Notice post', textStyle: latoM20),
            child: Form(
              key: _formKeyCreateNoticePage,
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
                                      hintText: 'Add description about notice!',
                                      maxlines: 10,
                                      validator: Validator.validateDescription,
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
                          child: helpImage == null
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
                              : Image.file(helpImage!)),
                    ),
                    SizedBox(height: 40.h),
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
        helpImage = File(xImagePath);
      });
    }
  }

  _onPostEvent() async {
    if (_formKeyCreateNoticePage.currentState!.validate()) {
      bool created = await appStore.dispatch(GetCreateNoticeAction(
          title: titleController.text,
          description: descriptionController.text,
          imagePath: helpImage?.path));

      if (!created) {
        showAlertDialog(context,
            text:
                'There was a problem while uploading to server! Please, try again!');
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
