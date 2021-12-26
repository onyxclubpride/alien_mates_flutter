import 'package:ionicons/ionicons.dart';
import 'package:alien_mates/mgr/navigation/app_routes.dart';
import 'package:alien_mates/mgr/redux/action.dart';
import 'package:alien_mates/presentation/template/base/template.dart';

class DefaultHeader extends StatelessWidget implements PreferredSizeWidget {
  bool? centerTitle;
  Widget? titleIcon;
  Widget? leftButton;
  IconData? rightIcon;
  VoidCallback? onRightButtonClick;
  SizedText? titleText;
  bool withAction;

  DefaultHeader(
      {this.centerTitle = false,
      this.withAction = false,
      this.titleIcon,
      this.leftButton,
      this.onRightButtonClick,
      this.titleText,
      this.rightIcon});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: centerTitle,
      title: _buildTitle(),
      leading: leftButton,
      automaticallyImplyLeading: false,
      titleSpacing: 20.h,
      toolbarHeight: 70.h,
      actions: withAction ? _buildActions() : null,
    );
  }

  @override
  Size get preferredSize => Size(double.infinity, 70.h);

  Widget _buildTitle() {
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start;
    if (centerTitle! || leftButton != null) {
      mainAxisAlignment = MainAxisAlignment.center;
    }
    Widget _container = Container();
    _container = Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        if (titleIcon != null) titleIcon!,
        if (titleIcon != null) SizedBox(width: 10.w),
        titleText ??
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
            // appStore.dispatch(GetCreateEventAction(
            //     eventLocation: 'Seoul',
            //     title: "Cool event",
            //     description: "Cool event desc",
            //     joinLimit: 10,
            //     imagePath: ''));
            appStore.dispatch(NavigateToAction(to: AppRoutes.profilePageRoute));
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
