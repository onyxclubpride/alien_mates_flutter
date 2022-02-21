import 'package:flutter/services.dart';
import 'package:alien_mates/presentation/template/base/template.dart';
import 'package:alien_mates/utils/common/constants.dart';

class DescriptionCreateInput extends StatelessWidget {
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
  int? maxlines;
  double? height;

  DescriptionCreateInput({
    this.hintText,
    this.validator,
    this.onTap,
    this.height,
    this.controller,
    this.errorText,
    this.readOnly = false,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.maxlines,
    this.textInputAction = TextInputAction.next,
    this.isObscured = false,
    this.regexPattern,
    this.onChanged,
    this.isFocusBorderEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        style: latoR16.copyWith(color: ThemeColors.fontWhite),
        validator: validator,
        controller: controller,
        obscureText: isObscured!,
        autofocus: false,
        onTap: onTap,
        maxLines: maxlines,
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
          fillColor:
              readOnly! ? ThemeColors.fontDark : ThemeColors.componentBgDark,
          hintText: hintText ?? '',
          errorText: errorText,
          suffixIcon: suffixIcon,
          errorStyle: latoR14.copyWith(color: ThemeColors.coolgray300),
          errorMaxLines: 2,
          hintStyle: latoR14.copyWith(color: ThemeColors.gray1),
          contentPadding: EdgeInsets.all(10.h),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.r)),
              borderSide: BorderSide(width: 1.w, color: ThemeColors.gray1)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.r)),
              borderSide: BorderSide(width: 1.w, color: ThemeColors.yellow300)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.r)),
              borderSide: BorderSide(width: 1.w, color: ThemeColors.red)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.r)),
              borderSide: BorderSide(
                  width: 1.w,
                  color: !isFocusBorderEnabled!
                      ? ThemeColors.gray1
                      : ThemeColors.fontWhite)),
          // constraints: BoxConstraints(maxWidth: 324.w, maxHeight: height),
        ));
  }
}
