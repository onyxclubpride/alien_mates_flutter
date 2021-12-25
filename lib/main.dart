import 'package:firebase_core/firebase_core.dart';
import 'package:alien_mates/app.dart';
import 'package:alien_mates/presentation/template/base/template.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const AlienMatesApp());
}
