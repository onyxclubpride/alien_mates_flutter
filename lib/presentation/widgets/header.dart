import 'package:smart_house_flutter/presentation/template/base/template.dart';

class DefaultHeader extends StatelessWidget implements PreferredSizeWidget {
  bool? centerTitle;
  Widget? titleIcon;
  Widget? leftButton;

  DefaultHeader({this.centerTitle = false, this.titleIcon, this.leftButton});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: centerTitle,
      title: _buildTitle(),
      leading: leftButton,
      actions: _buildActions(),
    );
  }

  @override
  Size get preferredSize => Size(double.infinity, 44.h);

  Widget _buildTitle() {
    Widget _container = Container();
    _container = Row(
      children: [
        if (titleIcon != null) titleIcon!,
        if (titleIcon != null) SizedBox(width: 24.w),
        const SizedText(
          text: 'Alien Mates',
          textStyle: futuraB45,
        ),
      ],
    );
    return _container;
  }

  List<Widget> _buildActions() {
    List<Widget> _list = [];
    _list.add(IconButton(
      padding: EdgeInsets.zero,
      icon: const Icon(Icons.supervised_user_circle),
      iconSize: 30.h,
      onPressed: () {
        print('On Profile icon press');
      },
    ));
    return _list;
  }
}
