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
          EmotionSelectorContainer(),
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
  String _selectedTitle = "";
  String _selectedName = "";
  String _selectedImagePath = "";
  Color _selectedColor = Colors.white;

  void _showEmotionBottomSheet() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) => EmotionBottomSheet(
              onEmotionSelected: (title, name, color, imagePath) {
                setState(() {
                  _selectedTitle = title;
                  _selectedName = name;
                  _selectedColor = color;
                  _selectedImagePath = imagePath;
                });
              },
            ));
  }

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
              border: Border.all(color: Colors.black),
              color: _selectedColor),
          child: Row(
            children: [
              GestureDetector(
                onTap: _showEmotionBottomSheet,
                child: Container(
                  height: 50,
                  width: 50,
                  child: _selectedImagePath.isEmpty
                      ? Icon(
                          Icons.question_mark,
                          color: Colors.white,
                        )
                      : Image.asset(_selectedImagePath),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.black),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _selectedTitle.isEmpty
                          ? "Start selecting what you feel."
                          : "Your word of the day is $_selectedTitle",
                      style: const TextStyle(fontSize: 14),
                    ),
                    Text(
                      _selectedTitle.isEmpty
                          ? "Click the question mark to choose an emotion"
                          : "Seems like you are $_selectedName. Share what you feel in the journal.",
                      style: const TextStyle(fontSize: 10),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Emotion extends StatelessWidget {
  final String imagePath;
  final String title;
  final String name;
  final Color color;
  final Function(String, String, Color, String) onSelect;

  const Emotion({
    Key? key,
    required this.title,
    required this.name,
    required this.imagePath,
    required this.color,
    required this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onSelect(title, name, color, imagePath);
        Navigator.pop(context);
        // on tap of an emotion, the color, icon, and text of the emotion selector
        // should change
      },
      child: Column(
        children: [
          Image.asset(
            imagePath,
            width: 60,
            height: 60,
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(fontSize: 10),
          ),
          Text(
            "($name)",
            style: const TextStyle(fontSize: 10),
          )
        ],
      ),
    );
  }
}

class EmotionBottomSheet extends StatefulWidget {
  final Function(String, String, Color, String) onEmotionSelected;
  const EmotionBottomSheet({super.key, required this.onEmotionSelected});

  @override
  State<EmotionBottomSheet> createState() => _EmotionBottomSheetState();
}

class _EmotionBottomSheetState extends State<EmotionBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: MediaQuery.of(context).size.height * 0.6,
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
          SizedBox(height: 16),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // 1st row of emotions
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Emotion(
                        title: "YAY",
                        name: "happy",
                        imagePath: "lib/assets/images/emotions-happy.png",
                        color: Color(0xFFF8E9BB),
                        onSelect: (title, name, color, imagePath) {
                          widget.onEmotionSelected(
                              title, name, color, imagePath);
                        },
                      ),
                      Emotion(
                        title: "HUHU",
                        name: "sad",
                        imagePath: "lib/assets/images/emotions-sad.png",
                        color: Color(0xffe4edff),
                        onSelect: (title, name, color, imagePath) {
                          widget.onEmotionSelected(
                              title, name, color, imagePath);
                        },
                      ),
                      Emotion(
                        title: "GRAH",
                        name: "angry",
                        imagePath: "lib/assets/images/emotions-angry.png",
                        color: Color(0xFFfdb9b8),
                        onSelect: (title, name, color, imagePath) {
                          widget.onEmotionSelected(
                              title, name, color, imagePath);
                        },
                      )
                    ],
                  ),
                ),
                // 2nd row of emotions
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Emotion(
                        title: "SIGH",
                        name: "tired",
                        imagePath: "lib/assets/images/emotions-tired.png",
                        color: Color(0xFFf0ffcd),
                        onSelect: (title, name, color, imagePath) {
                          widget.onEmotionSelected(
                              title, name, color, imagePath);
                        },
                      ),
                      Emotion(
                        title: "WOAH",
                        name: "energetic",
                        imagePath: "lib/assets/images/emotions-energetic.png",
                        color: Color(0xFFffdca0),
                        onSelect: (title, name, color, imagePath) {
                          widget.onEmotionSelected(
                              title, name, color, imagePath);
                        },
                      ),
                      Emotion(
                        title: "MEH",
                        name: "neutral",
                        imagePath: "lib/assets/images/emotions-neutral.png",
                        color: Color(0xFFfdf1de),
                        onSelect: (title, name, color, imagePath) {
                          widget.onEmotionSelected(
                              title, name, color, imagePath);
                        },
                      ),
                      Emotion(
                        title: "YIE",
                        name: "in love",
                        imagePath: "lib/assets/images/emotions-love.png",
                        color: Color(0xFFffdbe7),
                        onSelect: (title, name, color, imagePath) {
                          widget.onEmotionSelected(
                              title, name, color, imagePath);
                        },
                      ),
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
                        imagePath: "lib/assets/images/emotions-curious.png",
                        color: Color(0xFFcffdf8),
                        onSelect: (title, name, color, imagePath) {
                          widget.onEmotionSelected(
                              title, name, color, imagePath);
                        },
                      ),
                      Emotion(
                        title: "WOMP",
                        name: "embarrassed",
                        imagePath: "lib/assets/images/emotions-embarrassed.png",
                        color: Color(0xFFffc4c4),
                        onSelect: (title, name, color, imagePath) {
                          widget.onEmotionSelected(
                              title, name, color, imagePath);
                        },
                      ),
                      Emotion(
                        title: "AAA",
                        name: "scared",
                        imagePath: "lib/assets/images/emotions-scared.png",
                        color: Color(0xFFffccab),
                        onSelect: (title, name, color, imagePath) {
                          widget.onEmotionSelected(
                              title, name, color, imagePath);
                        },
                      )
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
