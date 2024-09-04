import 'package:flutter/material.dart';
import '../assets/widgets/custom_appbar.dart';
import '../assets/widgets/screen_title.dart';

class BreatherPage extends StatefulWidget {
  const BreatherPage({super.key});

  @override
  State<BreatherPage> createState() => _BreatherPageState();
}

void main() => runApp(const BreatherPage());

class _BreatherPageState extends State<BreatherPage> {
  static const scaffoldBackgroundColor = Color(0xFFF1F3F4);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Inter",
        scaffoldBackgroundColor: scaffoldBackgroundColor,
      ),
      home: const Scaffold(
        body: Center(
          child: Column(
            children: <Widget>[
              ScreenTitle(
                title: "Journal",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
