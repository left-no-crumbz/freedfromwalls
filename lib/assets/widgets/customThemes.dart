import 'package:flutter/material.dart';

class AppThemes {

  static double getResponsiveFontSize(BuildContext context, double baseFontSize) {
    final double width = MediaQuery.of(context).size.width;
    final double scaleFactor = width / 360; // Adjust 360 based on your baseline
    return baseFontSize * scaleFactor;
  }

  static double getResponsiveImageSize(BuildContext context, double baseImageSize) {
    final double width = MediaQuery.of(context).size.width;
    final double scaleFactor = width / 360; // Adjust 360 based on your baseline screen width
    return baseImageSize * scaleFactor;
  }

  // Sunrise Theme
  static final ThemeData defaultTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Color(0xFFD7D5EE), //Used for main color
    cardColor: Color(0xFF56537C), //Used for secondary color
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.black,
      titleTextStyle: TextStyle(color: Colors.white),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Color(0xFFFFFFFF),
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
    ),
    scaffoldBackgroundColor: Color(0xFFFFFFFF),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.black),
      displaySmall: TextStyle(color: Color(0xFFD7D5EE)), //Used in grid view selected
      displayMedium: TextStyle(color: Color(0xFF56537C)), //Used in grid view unselected
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Color(0xFFFFCC99),  // Gold
    ),
    iconTheme: IconThemeData(color: Colors.black),
  );

  // Sunrise Theme
  static final ThemeData sunriseTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Color(0xFFFFCC99), //Used for main color
    cardColor: Color(0xFFC6541F), //Used for secondary color
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.black,
      titleTextStyle: TextStyle(color: Colors.white),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Color(0xFFF8EACB),
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
    ),
    scaffoldBackgroundColor: Color(0xFFF8EACB),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.black),
      displaySmall: TextStyle(color: Color(0xFFFFCC99)), //Used in grid view selected
      displayMedium: TextStyle(color: Color(0xFFC6541F)), //Used in grid view unselected
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Color(0xFFFFCC99),  // Gold
    ),
    iconTheme: IconThemeData(color: Colors.black),
  );

  // Sunset Theme
  static final ThemeData sunsetTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Color(0xFFE8AF78), //Used for main color
    cardColor: Color(0xFF993366), //Used for secondary color
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.black,
      titleTextStyle: TextStyle(color: Colors.white),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Color(0xFFF5CEDA),
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey[700],
    ),
    scaffoldBackgroundColor: Color(0xFFF5CEDA),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.black),
      displaySmall: TextStyle(color: Color(0xFFE8AF78)), //Used in grid view selected
      displayMedium: TextStyle(color: Color(0xFF993366)), //Used in grid view unselected
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF993366),  // Dark purple
    ),
    iconTheme: IconThemeData(color: Colors.black),
  );

  // Sunset Theme
  static final ThemeData midnightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Color(0xFF445478),
    cardColor: Color(0xFFF8D5D5),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.black,
      titleTextStyle: TextStyle(color: Colors.white),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Color(0xFFF5CEDA),
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey[700],
    ),
    scaffoldBackgroundColor: Color(0xFFA6B1C8),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.black),
      displaySmall: TextStyle(color: Color(0xFF445478)), //Used in grid view selected
      displayMedium: TextStyle(color: Color(0xFFF8D5D5)), //Used in grid view unselected
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF993366),  // Dark purple
    ),
    iconTheme: IconThemeData(color: Colors.black),
  );
}
