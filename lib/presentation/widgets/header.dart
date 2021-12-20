import 'package:smart_house_flutter/presentation/template/base/template.dart';


class DefaultHeader extends StatelessWidget implements PreferredSizeWidget {
  const DefaultHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: SizedText(text: 'Alien Mates'),
      actions: _buildActions(),
    );
  }

  @override
  Size get preferredSize => Size(double.infinity, 44.h);

  List<Widget> _buildActions(){
    List<Widget> _list = [];

    return _list;

  }
}
