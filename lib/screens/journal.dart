import 'package:flutter/material.dart';
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
      home: Scaffold(
        appBar: AppBar(
          leading: const ImageIcon(AssetImage("../assets/icons/logo.png")),
          foregroundColor: Colors.white,
          title: const Text(
              "FreedFromWalls"
          ),
        ),
      ),
    );
  }
}
