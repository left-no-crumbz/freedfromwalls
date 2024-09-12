import 'package:flutter/material.dart';
import './assets/widgets/custom_appbar.dart';
import './assets/widgets/custom_bottom_navigation_bar.dart';
import 'screens/home_screen.dart';
import 'screens/list_screen.dart';
import 'screens/breather_screen.dart';
import 'screens/feel_screen.dart';
import 'screens/profile_screen.dart';

void main() => runApp(const FreedFromWallsApp());

class FreedFromWallsApp extends StatelessWidget {
  const FreedFromWallsApp({super.key});
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
      appBar: const CustomAppBar(),
      bottomNavigationBar: CustomBottomNavigationBar(
        onItemSelected: onBottomNavItemTap,
        selectedIndex: _currentPageIndex,
      ),
      body: _pages[_currentPageIndex],
    );
  }
}
