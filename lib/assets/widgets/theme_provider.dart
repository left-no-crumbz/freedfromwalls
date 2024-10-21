import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:freedfromwalls/assets/widgets/customThemes.dart';

// TODO: Testing
class ThemeProvider extends ChangeNotifier {
  ThemeData _selectedTheme;
  final FlutterSecureStorage _localStorage = FlutterSecureStorage();

  ThemeProvider({required ThemeData initialTheme})
      : _selectedTheme = initialTheme {
    _loadTheme();
  }

  ThemeData get theme => _selectedTheme;

  void swapTheme(ThemeData newTheme, String email) async {
    _selectedTheme = newTheme;
    notifyListeners();

    // Store the selected theme with the user's email as the key
    await _localStorage.write(
        key: '${email}_theme', value: _themeName(newTheme));
  }

  Future<void> _loadTheme() async {
    String? email = await _localStorage.read(key: 'current_user_email');
    if (email != null) {
      String? storedTheme = await _localStorage.read(key: '${email}_theme');

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
