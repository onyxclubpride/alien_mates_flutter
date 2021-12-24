import 'package:ionicons/ionicons.dart';
import 'package:smart_house_flutter/presentation/template/base/template.dart';

class DefaultHeader extends StatelessWidget implements PreferredSizeWidget {
  bool? centerTitle;
  Widget? titleIcon;
  Widget? leftButton;
  IconData? rightIcon;
  VoidCallback? onRightButtonClick;

  DefaultHeader(
      {this.centerTitle = false,
      this.titleIcon,
      this.leftButton,
      this.onRightButtonClick,
      this.rightIcon});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: centerTitle,
      title: _buildTitle(),
      leading: leftButton,
      titleSpacing: 20.h,
      actions: _buildActions(),
    );
  }

  @override
  Size get preferredSize => Size(double.infinity, 90.h);

  Widget _buildTitle() {
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start;
    if (centerTitle! || leftButton != null) {
      mainAxisAlignment = MainAxisAlignment.center;
    }
    print(mainAxisAlignment);
    Widget _container = Container();
    _container = Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        if (titleIcon != null) titleIcon!,
        if (titleIcon != null) SizedBox(width: 24.w),
        SizedText(
          text: 'Alien Mates',
          textStyle: latoM36,
        ),
      ],
    );
    return _container;
  }

  List<Widget> _buildActions() {
    List<Widget> _list = [];
    if (rightIcon == null) {
      _list.add(Container(
        margin: EdgeInsets.only(right: 10.w),
        child: IconButton(
          padding: EdgeInsets.zero,
          icon: const Icon(Ionicons.person, color: ThemeColors.bgLight),
          iconSize: 30.h,
          onPressed: () {
            print('On Profile icon press');
          },
        ),
      ));
    } else {
      _list.add(Container(
        margin: EdgeInsets.only(right: 10.w),
        child: IconButton(
          padding: EdgeInsets.zero,
          icon: Icon(rightIcon!, color: ThemeColors.bgLight),
          iconSize: 30.h,
          onPressed: onRightButtonClick,
        ),
      ));
    }
    return _list;
  }
}
