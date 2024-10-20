import 'package:flutter/material.dart';
import 'package:freedfromwalls/providers/blacklist_provider.dart';
import 'package:freedfromwalls/providers/bucketlist_provider.dart';
import 'package:freedfromwalls/providers/fullfeelment_provider.dart';
import './assets/widgets/custom_appbar.dart';
import './assets/widgets/custom_bottom_navigation_bar.dart';
import 'assets/widgets/customThemes.dart';
import 'assets/widgets/theme_provider.dart';
import 'screens/home_screen.dart';
import 'screens/list_screen.dart';
import 'screens/breather_screen.dart';
import 'screens/feel_screen.dart';
import 'screens/profile_screen.dart';
import 'package:provider/provider.dart';
import './providers/user_provider.dart';
import './providers/emotion_provider.dart';
import './providers/daily_entry_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => ThemeProvider(initialTheme: AppThemes.defaultTheme)),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => EmotionProvider()),
        ChangeNotifierProvider(create: (_) => DailyEntryProvider()),
        ChangeNotifierProvider(create: (_) => BucketListProvider()),
        ChangeNotifierProvider(create: (_) => BlackListProvider()),
        ChangeNotifierProvider(create: (_) => FeelProvider()),
      ],
      child: const FreedFromWallsApp(),
    ),
  );
}

class FreedFromWallsApp extends StatelessWidget {
  const FreedFromWallsApp({super.key});

  @override
  Widget build(BuildContext context) {
    var currentTheme = Provider.of<ThemeProvider>(context).theme;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: currentTheme,
      home: const AppState(),
    );
  }
}

class AppState extends StatefulWidget {
  const AppState({super.key});

  @override
  State<AppState> createState() => AppStateStates();
}

class AppStateStates extends State<AppState> {
  int _currentPageIndex = 0;

  void onBottomNavItemTap(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  static const _pages = <Widget>[
    HomePage(),
    ListPage(),
    BreatherPage(),
    FeelPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const CustomAppBar(),
      bottomNavigationBar: CustomBottomNavigationBar(
        onItemSelected: onBottomNavItemTap,
        selectedIndex: _currentPageIndex,
      ),
      body: _pages[_currentPageIndex],
    );
  }
}

// kadizon4@student.hau.edu.ph |||| root

// TODO: Remember me button, Themes sharedPref(remember selected theme), Register going to Onboarding