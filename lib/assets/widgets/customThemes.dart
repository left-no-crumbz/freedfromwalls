import 'package:flutter/material.dart';

class AppThemes {
  static double getResponsiveFontSize(
      BuildContext context, double baseFontSize) {
    final double width = MediaQuery.of(context).size.width;
    final double scaleFactor = width / 360; // Adjust 360 based on your baseline
    return baseFontSize * scaleFactor;
  }

  static double getResponsiveImageSize(
      BuildContext context, double baseImageSize) {
    final double width = MediaQuery.of(context).size.width;
    final double scaleFactor =
        width / 360; // Adjust 360 based on your baseline screen width
    return baseImageSize * scaleFactor;
  }

  static String getListImages(
      bool isBucketListSelected, ThemeData currentTheme) {
    if (isBucketListSelected) {
      if (currentTheme == defaultTheme) {
        return 'lib/assets/images/backgrounds/Default_Bucketlisted.png';
      } else if (currentTheme == sunriseTheme) {
        return 'lib/assets/images/backgrounds/Sunrise_Bucketlisted.png';
      } else if (currentTheme == sunsetTheme) {
        return 'lib/assets/images/backgrounds/Sunset_Bucketlisted.png';
      } else if (currentTheme == midnightTheme) {
        return 'lib/assets/images/backgrounds/Midnight_Bucketlisted.png';
      }
    } else {
      if (currentTheme == defaultTheme) {
        return 'lib/assets/images/backgrounds/Default_Blacklisted.png';
      } else if (currentTheme == sunriseTheme) {
        return 'lib/assets/images/backgrounds/Sunrise_Blacklisted.png';
      } else if (currentTheme == sunsetTheme) {
        return 'lib/assets/images/backgrounds/Sunset_Blacklisted.png';
      } else if (currentTheme == midnightTheme) {
        return 'lib/assets/images/backgrounds/Midnight_Blacklisted.png';
      }
    }

    return 'lib/assets/images/backgrounds/Default_Bucketlisted.png';
  }

  static String getFeelImages(ThemeData currentTheme) {
    if (currentTheme == defaultTheme) {
      return 'lib/assets/images/backgrounds/Default_Fullfeelment.png';
    } else if (currentTheme == sunriseTheme) {
      return 'lib/assets/images/backgrounds/Sunrise_Fullfeelment.png';
    } else if (currentTheme == sunsetTheme) {
      return 'lib/assets/images/backgrounds/Sunset_Fullfeelment.png';
    } else if (currentTheme == midnightTheme) {
      return 'lib/assets/images/backgrounds/Midnight_Fullfeelment.png';
    } else {
      return 'lib/assets/images/backgrounds/Default_Fullfeelment.png';
    }
  }

  // Sunrise Theme
  static final ThemeData defaultTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Color(0xFFD7D5EE), //Used for main color
    cardColor: Color(0xFF56537C), //Used for secondary color
    scaffoldBackgroundColor: Color(0xFFFFFFFF), //Background color for body
    textTheme: TextTheme(
      displaySmall:
          TextStyle(color: Color(0xFFD7D5EE)), //Used in grid view selected
      displayMedium:
          TextStyle(color: Color(0xFF56537C)), //Used in grid view unselected
    ),
  );

  // Sunrise Theme
  static final ThemeData sunriseTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Color(0xFFFFCC99), //Used for main color
    cardColor: Color(0xFFC6541F), //Used for secondary color
    scaffoldBackgroundColor: Color(0xFFF8EACB), //Background color for body
    textTheme: TextTheme(
      displaySmall:
          TextStyle(color: Color(0xFFFFCC99)), //Used in grid view selected
      displayMedium:
          TextStyle(color: Color(0xFFC6541F)), //Used in grid view unselected
    ),
  );

  // Sunset Theme
  static final ThemeData sunsetTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Color(0xFFE5B4BE), //Used for unselected
    cardColor: Color(0xFF752939), //Used for selected
    scaffoldBackgroundColor: Color(0xFFF5CEDA), //Background color for body
    textTheme: TextTheme(
      displaySmall: TextStyle(color: Color(0xFFE5B4BE)), //Used for selected
      displayMedium: TextStyle(color: Color(0xFF752939)), //Used for unselected
    ),
  );

  // Sunset Theme
  static final ThemeData midnightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Color(0xFFB3C2E1), //Used for unselected
    cardColor: Color(0xFF445478), //Used for selected
    scaffoldBackgroundColor: Color(0xFFA6B1C8), //Background color for body
    textTheme: TextTheme(
      displaySmall: TextStyle(color: Color(0xFFB3C2E1)), //Used for selected
      displayMedium: TextStyle(color: Color(0xFF445478)), //Used for unselected
    ),
  );
}
