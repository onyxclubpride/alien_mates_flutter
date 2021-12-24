import 'package:firebase_core/firebase_core.dart';
import 'package:smart_house_flutter/app.dart';
import 'package:smart_house_flutter/presentation/template/base/template.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const AlienMatesApp());
}
