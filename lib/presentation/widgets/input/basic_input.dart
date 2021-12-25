import 'package:flutter/services.dart';
import 'package:smart_house_flutter/presentation/template/base/template.dart';
import 'package:smart_house_flutter/utils/common/constants.dart';

class BasicInput extends StatelessWidget {
  String? hintText;
  String? Function(String?)? validator;
  TextEditingController? controller;
  String? errorText;
  bool? isObscured;
  bool? readOnly;
  Widget? suffixIcon;
  TextInputType? keyboardType;
  ValueChanged? onChanged;
  TextInputAction? textInputAction;
  VoidCallback? onTap;
  bool? isFocusBorderEnabled;
  RegExp? regexPattern;

  BasicInput(
      {this.hintText,
      this.validator,
      this.onTap,
      this.controller,
      this.errorText,
      this.readOnly = false,
      this.suffixIcon,
      this.keyboardType = TextInputType.text,
      this.textInputAction = TextInputAction.next,
      this.isObscured = false,
      this.regexPattern,
      this.onChanged,
      this.isFocusBorderEnabled = true});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        style: latoR14,
        validator: validator,
        controller: controller,
        obscureText: isObscured!,
        onTap: onTap,
        inputFormatters: <TextInputFormatter>[
          if (regexPattern != null)
            FilteringTextInputFormatter.allow(regexPattern!)
        ],
        keyboardType: keyboardType,
        readOnly: readOnly!,
        onChanged: onChanged,
        textInputAction: textInputAction,
        decoration: InputDecoration(
          filled: true,
          fillColor: readOnly! ? ThemeColors.fontDark : ThemeColors.fontLight,
          hintText: hintText != null
              ? AppLocalizations.of(context)!.getString(hintText)
              : '입력',
          errorText: errorText,
          suffixIcon: suffixIcon,
          errorStyle: latoR14.copyWith(color: ThemeColors.red),
          errorMaxLines: 2,
          hintStyle:
              latoR14.copyWith(color: ThemeColors.gray1),
          contentPadding:
              EdgeInsets.symmetric(horizontal: 14.w, vertical: 15.h),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4.r)),
              borderSide: BorderSide(width: 1, color: ThemeColors.gray1)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4.r)),
              borderSide: BorderSide(width: 1, color: ThemeColors.red)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4.r)),
              borderSide: BorderSide(width: 1, color: ThemeColors.red)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4.r)),
              borderSide: BorderSide(
                  width: 1,
                  color: !isFocusBorderEnabled!
                      ? ThemeColors.gray1
                      : ThemeColors.yellow)),
          constraints: BoxConstraints(maxWidth: 324.w),
        ));
  }
}