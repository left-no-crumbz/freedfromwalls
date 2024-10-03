import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'assets/widgets/customThemes.dart';
import 'assets/widgets/theme_provider.dart';
import 'screens/login_screen.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(initialTheme: AppThemes.sunriseTheme),
      child: FreedFromWallsLogin(),
    ),
  );
}

class FreedFromWallsLogin extends StatelessWidget {
  const FreedFromWallsLogin({super.key});

  @override
  Widget build(BuildContext context) {
    var currentTheme = Provider.of<ThemeProvider>(context).theme;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: currentTheme,
      home: LoginPage(),
    );
  }
}
