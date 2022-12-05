import 'package:firebase_core/firebase_core.dart';
import 'package:alien_mates/app.dart';
import 'package:alien_mates/presentation/template/base/template.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: ThemeColors.black,
  ));
  await Firebase.initializeApp();

  await Hive.initFlutter();

  await Hive.openBox("auth");

  runApp(const AlienMatesApp());
}
