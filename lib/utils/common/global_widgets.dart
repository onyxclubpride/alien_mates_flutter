import 'package:flutter/material.dart';
import 'package:alien_mates/utils/localization/localizations.dart';

class GlobalWidgets {
  static final GlobalWidgets _singleton = GlobalWidgets._internal();

  final _keys = <String, GlobalKey>{};

  factory GlobalWidgets() => _singleton;

  GlobalWidgets._internal();

  GlobalKey<T> key<T extends State<StatefulWidget>>(String name) {
    if (_keys[name] == null) {
      _keys[name] = GlobalKey<T>();
    }

    return _keys[name] as GlobalKey<T>;
  }

  T? state<T extends State?>(String name) {
    if (_keys[name] == null) {
      return null;
    }

    return _keys[name]!.currentState as T;
  }

  void reload(String? name) {
    if (_keys[name!] == null || !(_keys[name]!.currentState is Reloadable)) {
      return;
    }

    (_keys[name]!.currentState as Reloadable).reload();
  }

  void refresh(String name) {
    if (_keys[name] == null) {
      return;
    }

    // ignore: invalid_use_of_protected_member
    _keys[name]!.currentState!.setState(() {});
  }
}

class Reloadable {
  void reload() {}
}

class Global {
  static final navKey = GlobalKey<NavigatorState>();
  static final navState = navKey.currentState;
  static final appKey = GlobalWidgets().key('/');
  static final appContext = appKey.currentContext;
  static final bodyKey = GlobalKey();

  static final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  static getString(String? key) =>
      AppLocalizations.of(appContext!)!.getString(key);
}
