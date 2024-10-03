import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _selectedTheme;

  ThemeProvider({required ThemeData initialTheme}) : _selectedTheme = initialTheme;

  ThemeData get theme => _selectedTheme;

  void swapTheme(ThemeData newTheme) {
    _selectedTheme = newTheme;
    notifyListeners();
  }
}
