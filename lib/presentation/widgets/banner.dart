import 'package:smart_house_flutter/presentation/template/base/template.dart';

class DefaultBanner extends StatelessWidget {

  Widget? child;
  DefaultBanner({ this.child});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: child),
        decoration: BoxDecoration(
        borderRadius:BorderRadius.circular(10.r), 
        color: ThemeColors.componentBgDark,
        border: Border.all(
          color: ThemeColors.borderDark
        )
      ),
      
      margin: const EdgeInsets.all(10.0),
      width: 360.w,
      height: 48.h,
    );
  }
}
