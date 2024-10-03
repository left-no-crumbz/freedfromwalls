import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../assets/widgets/customThemes.dart';
import '../assets/widgets/theme_provider.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
              'Theme Settings'
          ),
          iconTheme: IconThemeData(
              color: Colors.white
          ),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text('Default'),
            leading: Radio(
              value: AppThemes.defaultTheme,
              groupValue: Provider.of<ThemeProvider>(context).theme,
              onChanged: (ThemeData? value) {
                if (value != null) {
                  Provider.of<ThemeProvider>(context, listen: false).swapTheme(value);
                }
              },
            ),
          ),
          ListTile(
            title: Text('Sunrise'),
            leading: Radio(
              value: AppThemes.sunriseTheme,
              groupValue: Provider.of<ThemeProvider>(context).theme,
              onChanged: (ThemeData? value) {
                if (value != null) {
                  Provider.of<ThemeProvider>(context, listen: false).swapTheme(value);
                }
              },
            ),
          ),
          ListTile(
            title: Text('Sunset'),
            leading: Radio(
              value: AppThemes.sunsetTheme,
              groupValue: Provider.of<ThemeProvider>(context).theme,
              onChanged: (ThemeData? value) {
                if (value != null) {
                  Provider.of<ThemeProvider>(context, listen: false).swapTheme(value);
                }
              },
            ),
          ),
          ListTile(
            title: Text('Midnight'),
            leading: Radio(
              value: AppThemes.midnightTheme,
              groupValue: Provider.of<ThemeProvider>(context).theme,
              onChanged: (ThemeData? value) {
                if (value != null) {
                  Provider.of<ThemeProvider>(context, listen: false).swapTheme(value);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
