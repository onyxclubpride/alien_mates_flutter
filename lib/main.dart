import 'package:firebase_core/firebase_core.dart';
import 'package:alien_mates/app.dart';
import 'package:alien_mates/presentation/template/base/template.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Firebase.initializeApp();
  runApp(const AlienMatesApp());

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: ThemeColors.black,
  ));
}
