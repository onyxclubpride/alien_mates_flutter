import 'package:flutter/services.dart';
import 'package:smart_house_flutter/presentation/template/base/template.dart';

class InputWithLimit extends StatefulWidget {
  String hintText;
  TextEditingController controller;
  String? Function(String?)? validator;

  InputWithLimit({
    Key? key,
    required this.hintText,
    required this.controller,
    this.validator,
  }) : super(key: key);

  @override
  State<InputWithLimit> createState() => _InputWithLimitState();
}

class _InputWithLimitState extends State<InputWithLimit> {
  void onValueChange() {
    setState(() {
      widget.controller.text;
    });
  }

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(onValueChange);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(6),
      color: ThemeColors.fontLight,
      child: TextFormField(
        controller: widget.controller,
        validator: widget.validator,
        maxLines: 4,
        style: latoR14,
        inputFormatters: [LengthLimitingTextInputFormatter(500)],
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(top: 5.h, left: 9.w),
          hintText: widget.hintText,
          constraints: BoxConstraints(maxWidth: 324.w),
          counterText: '${widget.controller.text.length}/500',
          counterStyle: latoR14,
          filled: true,
          fillColor: ThemeColors.fontLight,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
