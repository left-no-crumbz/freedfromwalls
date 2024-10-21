import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:freedfromwalls/assets/widgets/customThemes.dart';
import 'package:freedfromwalls/providers/user_provider.dart';
import 'package:provider/provider.dart';

import '../../models/user.dart';

// TODO: Testing
class ThemeProvider extends ChangeNotifier {
  ThemeData _selectedTheme;
  final FlutterSecureStorage _localStorage = FlutterSecureStorage();
  String? _userEmail;
  ThemeProvider({required ThemeData initialTheme})
      : _selectedTheme = initialTheme {
    _loadTheme();
  }

  ThemeData get theme => _selectedTheme;

  void setUserEmail(String email) async {
    _userEmail = email;
    await _loadTheme();
  }

  void swapTheme(ThemeData newTheme) async {
    if (_userEmail != null) {
      _selectedTheme = newTheme;
      notifyListeners();
      await _localStorage.write(
          key: '${_userEmail}_theme', value: _themeName(newTheme));
    }
  }

  Future<void> _loadTheme() async {
    if (_userEmail != null) {
      String? storedTheme =
          await _localStorage.read(key: '${_userEmail}_theme');

      if (storedTheme != null) {
        switch (storedTheme) {
          case 'Sunset':
            _selectedTheme = AppThemes.sunsetTheme;
            break;
          case 'Sunrise':
            _selectedTheme = AppThemes.sunriseTheme;
            break;
          case 'Midnight':
            _selectedTheme = AppThemes.midnightTheme;
            break;
          default:
            _selectedTheme = AppThemes.defaultTheme;
        }
        notifyListeners();
      }
    }
  }

  String _themeName(ThemeData theme) {
    if (theme == AppThemes.sunsetTheme) return 'Sunset';
    if (theme == AppThemes.sunriseTheme) return 'Sunrise';
    if (theme == AppThemes.midnightTheme) return 'Midnight';
    return 'Default';
  }
}
