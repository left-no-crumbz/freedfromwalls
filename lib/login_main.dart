import 'package:flutter/material.dart';
import 'package:freedfromwalls/providers/daily_entry_provider.dart';
import 'package:provider/provider.dart';
import 'assets/widgets/customThemes.dart';
import 'assets/widgets/theme_provider.dart';
import 'providers/bucketlist_provider.dart';
import 'screens/login_screen.dart';
import 'package:flutter/services.dart';
import './providers/user_provider.dart';
import './providers/emotion_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => ThemeProvider(initialTheme: AppThemes.defaultTheme)),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => EmotionProvider()),
        ChangeNotifierProvider(create: (_) => DailyEntryProvider()),
        ChangeNotifierProvider(create: (_) => BucketListProvider()),
      ],
      child: const FreedFromWallsLogin(),
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
      home: const LoginPage(),
    );
  }
}
