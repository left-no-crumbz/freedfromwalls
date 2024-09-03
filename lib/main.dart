import 'package:flutter/material.dart';
import './assets/widgets/custom_appbar.dart';
import './assets/widgets/screen_title.dart';

class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key});

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

void main() {
  runApp(const JournalScreen());
}

class _JournalScreenState extends State<JournalScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Inter",
      ),
      home: const Scaffold(
        appBar: CustomAppBar(),
        body: Center(
          child: Column(
            children: <Widget>[
              ScreenTitle(
                title: "Journal",
              ),
              SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
