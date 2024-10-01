import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(FreedFromWallsLogin());
}

class FreedFromWallsLogin extends StatelessWidget {
  const FreedFromWallsLogin({super.key});
  static const scaffoldBackgroundColor = Color(0xFFF1F3F4);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: "Inter",
        scaffoldBackgroundColor: scaffoldBackgroundColor,
      ),
      home: LoginPage(),
    );
  }
}
