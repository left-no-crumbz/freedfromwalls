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
                      builder: (BuildContext context) => EmotionBottomSheet());
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
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Emotion extends StatefulWidget {
  final String imagePath;
  final String title;
  final String name;
  const Emotion(
      {super.key,
      required this.title,
      required this.name,
      required this.imagePath});

  @override
  State<Emotion> createState() => _EmotionState();
}

class _EmotionState extends State<Emotion> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Column(
        children: [
          Image.asset(
            widget.imagePath,
            width: 60,
            height: 60,
          ),
          const SizedBox(height: 8),
          Text(
            widget.title,
            style: const TextStyle(fontSize: 10),
          ),
          Text(
            "(${widget.name})",
            style: const TextStyle(fontSize: 10),
          )
        ],
      ),
    );
  }
}

class EmotionBottomSheet extends StatefulWidget {
  const EmotionBottomSheet({super.key});

  @override
  State<EmotionBottomSheet> createState() => _EmotionBottomSheetState();
}

class _EmotionBottomSheetState extends State<EmotionBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: MediaQuery.of(context).size.height *
          0.8, // Increased height for better spacing
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          // Title
          Text(
            "How do you feel right now?",
            style: TextStyle(fontSize: 20),
          ),
          Text(
            "Please select one emotion below.",
            style: TextStyle(fontSize: 12),
          ),
          SizedBox(height: 16), // Added spacing after title
          // Emotions grid
          Expanded(
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.spaceEvenly, // Even spacing between rows
              children: [
                // 1st row of emotions
                Expanded(
                  child: Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceEvenly, // Even spacing in row
                    children: [
                      Emotion(
                          title: "YAY",
                          name: "happy",
                          imagePath: "lib/assets/images/emotions-happy.png"),
                      Emotion(
                          title: "HUHU",
                          name: "sad",
                          imagePath: "lib/assets/images/emotions-sad.png"),
                      Emotion(
                          title: "GRAH",
                          name: "angry",
                          imagePath: "lib/assets/images/emotions-angry.png")
                    ],
                  ),
                ),
                // 2nd row of emotions
                Expanded(
                  child: Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceEvenly, // Even spacing in row
                    children: [
                      Emotion(
                          title: "SIGH",
                          name: "tired",
                          imagePath: "lib/assets/images/emotions-tired.png"),
                      Emotion(
                          title: "WOAH",
                          name: "energetic",
                          imagePath:
                              "lib/assets/images/emotions-energetic.png"),
                      Emotion(
                          title: "MEH",
                          name: "neutral",
                          imagePath: "lib/assets/images/emotions-neutral.png"),
                      Emotion(
                          title: "YIE",
                          name: "in love",
                          imagePath: "lib/assets/images/emotions-love.png"),
                    ],
                  ),
                ),
                // 3rd row of emotions
                Expanded(
                  child: Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceEvenly, // Even spacing in row
                    children: [
                      Emotion(
                          title: "UHM",
                          name: "curious",
                          imagePath: "lib/assets/images/emotions-curious.png"),
                      Emotion(
                          title: "WOMP",
                          name: "embarrassed",
                          imagePath:
                              "lib/assets/images/emotions-embarrassed.png"),
                      Emotion(
                          title: "AAA",
                          name: "scared",
                          imagePath: "lib/assets/images/emotions-scared.png")
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
