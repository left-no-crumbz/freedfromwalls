import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../assets/widgets/customThemes.dart';
import '../assets/widgets/theme_provider.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
              'Theme Settings',
              style: TextStyle(
                color: Colors.white
              ),
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          children: [
            _buildThemeOption(context, 'Default', AppThemes.defaultTheme),
            _buildThemeOption(context, 'Sunset',  AppThemes.sunsetTheme),
            _buildThemeOption(context, 'Sunrise',  AppThemes.sunriseTheme),
            _buildThemeOption(context, 'Midnight',  AppThemes.midnightTheme),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeOption(BuildContext context, String themeName, ThemeData theme) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);

    return Container(
      padding: EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: themeProvider.theme == theme ? theme.primaryColor : Color(0xFFE5E5EA),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: themeProvider.theme == theme ? theme.cardColor : Colors.black,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [theme.primaryColor, theme.cardColor, theme.scaffoldBackgroundColor],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: themeProvider.theme == theme ? theme.cardColor : Colors.black,
                  width: 1,
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.palette,
                  size: 40,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(themeName),
          SizedBox(height: 8),
          Radio<ThemeData>(
            value: theme,
            groupValue: themeProvider.theme,
            onChanged: (ThemeData? value) {
              if (value != null) {
                themeProvider.swapTheme(value);
              }
            },
          ),
        ],
      ),
    );
  }
}
