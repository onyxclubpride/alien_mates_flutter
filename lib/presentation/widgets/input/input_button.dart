import 'package:smart_house_flutter/presentation/template/base/template.dart';

class InputButton extends StatelessWidget {
  String? hintText;
  String? Function(String?)? validator;
  TextEditingController? controller;
  bool? turnedOn;
  void Function()? onTap;
  InputButton(
      {this.hintText,
      this.validator,
      this.controller,
      this.turnedOn = false,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: latoM16,
      validator: validator,
      controller: controller,
      readOnly: true,
      onTap: onTap,
      decoration: InputDecoration(
        hintText: AppLocalizations.of(context)!.getString(hintText) ?? '입력',
        prefixIcon: Padding(
          padding: EdgeInsets.only(right: 31.w, left: 19.w),
          child: Container(
            width: 28.w,
            height: 28.h,
            decoration: BoxDecoration(
                border: Border.all(
                    color: turnedOn! ? ThemeColors.yellow : ThemeColors.gray1,
                    width: 1.5.w),
                shape: BoxShape.circle),
            // child:
            // CustomIcon(
            //   imagePath: turnedOn!
            //       ? 'assets/icons/checked_ic.png'
            //       : 'assets/icons/unchecked_ic.png',
            //   height: 24.h,
            // ),
          ),
        ),
        hintStyle: latoR14
            .copyWith(color: turnedOn! ? ThemeColors.yellow : ThemeColors.gray1),
        contentPadding: EdgeInsets.symmetric(vertical: 14.h),
        filled: true,
        fillColor: ThemeColors.fontLight,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(7.r),
          ),
          borderSide: BorderSide(
              width: 1,
              color: turnedOn! ? ThemeColors.yellow : ThemeColors.gray1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(7.r),
          ),
          borderSide: BorderSide(
              width: 1,
              color: turnedOn! ? ThemeColors.yellow : ThemeColors.gray1),
        ),
        constraints: BoxConstraints(
          maxWidth: 232.w,
        ),
      ),
    );
  }
}
