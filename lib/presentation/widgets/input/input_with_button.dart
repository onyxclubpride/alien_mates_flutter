import 'package:smart_house_flutter/presentation/template/base/template.dart';
import 'basic_input.dart';

class InputWithButton extends StatelessWidget {
  void Function()? onPressed;
  String? hint;
  String? Function(String?)? validator;
  String buttonText;
  String? errorText;
  TextEditingController? controller;
  Widget? suffixIcon;
  TextInputType? keyboardType;
  bool? readOnly;
  ValueChanged? onChanged;
  VoidCallback? onTap;
  bool? isFocusBorderEnabled;

  InputWithButton(
      {this.validator,
      this.onPressed,
      this.hint,
      this.readOnly = false,
      required this.buttonText,
      this.suffixIcon,
      this.controller,
      this.onChanged,
      this.errorText,
      this.onTap,
      this.keyboardType = TextInputType.text,
      this.isFocusBorderEnabled = true});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            flex: 3,
            child: BasicInput(
              onTap: onTap,
              readOnly: readOnly,
              controller: controller,
              errorText: errorText,
              validator: validator,
              keyboardType: keyboardType,
              hintText: hint,
              onChanged: onChanged,
              suffixIcon: suffixIcon,
              isFocusBorderEnabled: isFocusBorderEnabled,
            )),
        SizedBox(
          width: 8.w,
        ),
        Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.only(top: 2.h),

            ))
      ],
    );
  }
}
