import 'package:flutter/material.dart';

class EmotionSelector extends StatefulWidget {
  const EmotionSelector({super.key});

  @override
  State<EmotionSelector> createState() => _EmotionSelectorState();
}

class _EmotionSelectorState extends State<EmotionSelector> {
  static const dividerColor = Color(0xFF423e3d);
  String? _selectedEmotion;
  bool _isEditing = false;

  void _toggleEditMode() {
    setState(() {
      _isEditing = !_isEditing;
    });
    // TODO: Save data to database when editing is done
  }

  void _updateSelectedEmotion(String? value) {
    setState(() {
      if (_isEditing) {
        _selectedEmotion = value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .9,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 30,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 16, right: 4),
            child: Row(children: [
              const Text(
                "How do you feel right now?",
                style: TextStyle(fontSize: 12),
              ),
              const Expanded(child: SizedBox()),
              IconButton(
                iconSize: 20,
                padding: EdgeInsets.zero,
                onPressed: _toggleEditMode,
                constraints:
                    const BoxConstraints.tightFor(width: 20, height: 20),
                icon: _isEditing ? Icon(Icons.check) : Icon(Icons.edit_note),
              ),
            ]),
          ),
          const Divider(
            height: 2,
            color: dividerColor,
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 16, left: 8, right: 8, bottom: 8),
            child: Column(
              children: [
                Row(
                  children: [
                    EmotionSelection(
                      imagePath: "lib/assets/images/emotions-happy.png",
                      title: "YAY",
                      emotionName: "happy",
                      groupValue: _selectedEmotion,
                      onChanged: _updateSelectedEmotion,
                    ),
                    EmotionSelection(
                      imagePath: "lib/assets/images/emotions-sad.png",
                      title: "HUHU",
                      emotionName: "sad",
                      groupValue: _selectedEmotion,
                      onChanged: _updateSelectedEmotion,
                    ),
                    EmotionSelection(
                      imagePath: "lib/assets/images/emotions-angry.png",
                      title: "GRAH",
                      emotionName: "angry",
                      groupValue: _selectedEmotion,
                      onChanged: _updateSelectedEmotion,
                    ),
                    EmotionSelection(
                      imagePath: "lib/assets/images/emotions-neutral.png",
                      title: "MEH",
                      emotionName: "neutral",
                      groupValue: _selectedEmotion,
                      onChanged: _updateSelectedEmotion,
                    ),
                    EmotionSelection(
                      imagePath: "lib/assets/images/emotions-love.png",
                      title: "YIE",
                      emotionName: "in love",
                      groupValue: _selectedEmotion,
                      onChanged: _updateSelectedEmotion,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    EmotionSelection(
                      imagePath: "lib/assets/images/emotions-tired.png",
                      title: "SIGH",
                      emotionName: "tired",
                      groupValue: _selectedEmotion,
                      onChanged: _updateSelectedEmotion,
                    ),
                    EmotionSelection(
                      imagePath: "lib/assets/images/emotions-energetic.png",
                      title: "WOAH",
                      emotionName: "energetic",
                      groupValue: _selectedEmotion,
                      onChanged: _updateSelectedEmotion,
                    ),
                    EmotionSelection(
                      imagePath: "lib/assets/images/emotions-curious.png",
                      title: "UHM",
                      emotionName: "curious",
                      groupValue: _selectedEmotion,
                      onChanged: _updateSelectedEmotion,
                    ),
                    EmotionSelection(
                      imagePath: "lib/assets/images/emotions-embarrassed.png",
                      title: "WOMP",
                      emotionName: "embarrassed",
                      groupValue: _selectedEmotion,
                      onChanged: _updateSelectedEmotion,
                    ),
                    EmotionSelection(
                      imagePath: "lib/assets/images/emotions-scared.png",
                      title: "AAA",
                      emotionName: "scared",
                      groupValue: _selectedEmotion,
                      onChanged: _updateSelectedEmotion,
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class EmotionSelection extends StatefulWidget {
  final String imagePath;
  final String title;
  final String emotionName;
  final String? groupValue;
  final ValueChanged<String?> onChanged;

  const EmotionSelection({
    super.key,
    required this.imagePath,
    required this.title,
    required this.emotionName,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  State<EmotionSelection> createState() => _EmotionSelectionState();
}

class _EmotionSelectionState extends State<EmotionSelection> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Column(
        children: [
          Image.asset(
            widget.imagePath,
            fit: BoxFit.cover,
          ),
          Text(
            widget.title,
            style: TextStyle(fontSize: 8),
          ),
          Text(
            "(${widget.emotionName})",
            style: TextStyle(fontSize: 8),
          ),
          SizedBox(
            height: 30,
            child: Radio(
              value: widget.emotionName,
              groupValue: widget.groupValue,
              onChanged: widget.onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
