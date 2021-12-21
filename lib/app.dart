import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_house_flutter/mgr/navigation/app_routes.dart';
import 'package:smart_house_flutter/mgr/redux/action.dart';
import 'package:smart_house_flutter/mgr/redux/app_state.dart';
import 'package:smart_house_flutter/presentation/template/base/template.dart';
import 'package:smart_house_flutter/utils/common/constants.dart';
import 'package:smart_house_flutter/utils/common/global_widgets.dart';
import 'package:smart_house_flutter/utils/localization/localizations.dart';

class AlienMatesApp extends StatefulWidget {
  const AlienMatesApp({Key? key}) : super(key: key);

  @override
  _AlienMatesAppState createState() => _AlienMatesAppState();
}

class _AlienMatesAppState extends State<AlienMatesApp> {
  Locale? locale = Locale(AppLocalizations.languageCode.toString());

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 640),
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        builder: (context, child) => MediaQuery(
            child: child!,
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0)),
        title: Constants.appTitle,
        navigatorKey: Global.navKey,
        initialRoute: AppRoutes.homeRoute,
        theme: MainTheme.mainThemeDark,
        routes: AppRoutes.getRoutes(),
        navigatorObservers: [AppRouterObserver()],
        localizationsDelegates: const [
          AppLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'), // English
          Locale('kr'), // Korean
        ],
        locale: locale,
      ),
    );
  }
}

class AppRouterObserver extends RouteObserver<Route<dynamic>> {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    appStore.dispatch(UpdateNavigationAction(
        name: route.settings.name, isPage: route is PageRoute, method: 'push'));
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    appStore.dispatch(UpdateNavigationAction(
        name: (previousRoute?.settings.name) ?? "",
        isPage: previousRoute is PageRoute,
        method: 'pop'));
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    appStore.dispatch(UpdateNavigationAction(
        name: newRoute!.settings.name,
        isPage: newRoute is PageRoute,
        method: 'replace'));
  }
}
