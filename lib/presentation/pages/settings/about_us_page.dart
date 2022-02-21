import 'package:alien_mates/mgr/redux/action.dart';
import 'package:alien_mates/mgr/redux/app_state.dart';
import 'package:alien_mates/presentation/template/base/template.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ionicons/ionicons.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) => DefaultBody(
            withTopBanner: false,
            titleIcon: _buildTitleIcon(),
            withNavigationBar: false,
            withActionButton: false,
            titleText: SizedText(
              text: "Back",
              textStyle: latoM20,
            ),
            rightIcon: null,
            child: SingleChildScrollView(
              child: SpacedColumn(
                verticalSpace: 20,
                children: [
                  const SizedBox(),
                  SizedText(
                    text: 'About Us',
                    textStyle: latoB25.copyWith(color: ThemeColors.coolgray50),
                  ),
                  SizedText(
                    text: state.apiState.aboutUs,
                    textStyle: latoB20.copyWith(color: ThemeColors.coolgray300),
                    textAlign: TextAlign.justify,
                    overflow: TextOverflow.visible,
                  ),
                ],
              ),
            )));
  }

  Widget _buildTitleIcon() {
    return IconButton(
      padding: EdgeInsets.zero,
      iconSize: 30.w,
      icon: const Icon(Ionicons.chevron_back_outline),
      onPressed: () {
        appStore.dispatch(NavigateToAction(to: 'up'));
      },
    );
  }
}
