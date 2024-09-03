import 'package:flutter/material.dart';
import './assets/widgets/custom_appbar.dart';

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
      home: Scaffold(
        appBar: CustomAppBar(),
      ),
    );
  }
}
