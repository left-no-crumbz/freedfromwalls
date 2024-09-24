import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../assets/widgets/screen_title.dart';
import '../assets/widgets/unordered_list.dart';
import '../assets/widgets/emotion_selector.dart';
import '../assets/widgets/title_description.dart';

class BreatherPage extends StatefulWidget {
  const BreatherPage({super.key});

  @override
  State<BreatherPage> createState() => _BreatherPageState();
}

void main() => runApp(const BreatherPage());

class _BreatherPageState extends State<BreatherPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TitleDescription(
              title: "Breather", description: "Take a pause for a moment")
        ],
      ),
    );
  }
}
