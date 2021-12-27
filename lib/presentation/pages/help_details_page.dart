import 'package:alien_mates/mgr/redux/action.dart';
import 'package:alien_mates/mgr/redux/app_state.dart';
import 'package:alien_mates/presentation/template/base/template.dart';
import 'package:alien_mates/presentation/widgets/button/expanded_btn.dart';
import 'package:alien_mates/presentation/widgets/cached_image_or_text_widget.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ionicons/ionicons.dart';

class HelpDetailsPage extends StatefulWidget {
  const HelpDetailsPage({Key? key}) : super(key: key);

  @override
  _HelpDetailsPageState createState() => _HelpDetailsPageState();
}

class _HelpDetailsPageState extends State<HelpDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) => SingleChildScrollView(
                child: DefaultBody(
              withNavigationBar: false,
              withTopBanner: false,
              titleIcon: _buildTitleIcon(),
              child: Container(
                child: SpacedColumn(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 120.0,
                        width: 120.0,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                                'https://picsum.photos/250?image=9'),
                          ),
                        ),
                      ),
                      Container(
                          child: const SingleChildScrollView(
                        child: Text("hello"),
                      )),
                      ExpandedButton(
                        text: 'Notice',
                        onPressed: () {
                          print("HELLO WORLD");
                        },
                      ),
                    ]),
              ),
            )));
  }

  Widget _buildTitleIcon() {
    return IconButton(
      padding: EdgeInsets.zero,
      iconSize: 25.w,
      icon: const Icon(Ionicons.chevron_back_outline),
      onPressed: () {
        appStore.dispatch(NavigateToAction(to: 'up'));
      },
    );
  }
}
