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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleDescription(
              title: "Breather", description: "Take a pause for a moment"),
          EmotionSelectorContainer()
        ],
      ),
    );
  }
}

class EmotionSelectorContainer extends StatefulWidget {
  const EmotionSelectorContainer({super.key});

  @override
  State<EmotionSelectorContainer> createState() =>
      _EmotionSelectorContainerState();
}

class _EmotionSelectorContainerState extends State<EmotionSelectorContainer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0, bottom: 8),
          child: const Text(
            "Today",
            style: const TextStyle(fontSize: 12),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 16, right: 16),
          padding: const EdgeInsets.all(16),
          width: MediaQuery.of(context).size.width * 1,
          height: 100,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.black)),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          padding: const EdgeInsets.all(16),
                          height: 700,
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  const Text(
                                    "How do you feel right now?",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  const Text(
                                    "Please select one emotion below.",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      });
                },
                child: Container(
                  height: 50,
                  width: 50,
                  child: Icon(
                    Icons.question_mark,
                    color: Colors.white,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.black),
                ),
              ),
              const SizedBox(width: 8),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Start selecting what you feel.",
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    "Click the question mark to choose an emotion",
                    style: const TextStyle(fontSize: 10),
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
