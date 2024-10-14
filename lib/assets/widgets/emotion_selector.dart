import 'package:flutter/material.dart';
import 'package:freedfromwalls/controllers/emotion_controller.dart';
import '../../providers/daily_entry_provider.dart';
import '../../providers/emotion_provider.dart';
import '../../controllers/daily_entry_controller.dart';
import '../../models/daily_entry.dart';
import './custom_title.dart';
import 'customThemes.dart';
import 'package:provider/provider.dart';
import '../../models/emotion.dart';

class EmotionSelectorContainer extends StatefulWidget {
  const EmotionSelectorContainer({super.key});

  @override
  State<EmotionSelectorContainer> createState() =>
      _EmotionSelectorContainerState();
}

class _EmotionSelectorContainerState extends State<EmotionSelectorContainer> {
  EmotionModel? _emotion;
  String? _selectedTitle;
  String? _selectedName;
  String _selectedImagePath = "";
  Color _selectedColor = Colors.white;
  final DailyEntryController controller = DailyEntryController();
  List<DailyEntryModel> entries = [];

  final Map<String, String> imagePaths = {
    "happy": "lib/assets/images/emotions/emotions-happy.png",
    "sad": "lib/assets/images/emotions/emotions-sad.png",
    "angry": "lib/assets/images/emotions/emotions-angry.png",
    "tired": "lib/assets/images/emotions/emotions-tired.png",
    "energetic": "lib/assets/images/emotions/emotions-energetic.png",
    "neutral": "lib/assets/images/emotions/emotions-neutral.png",
    "in love": "lib/assets/images/emotions/emotions-love.png",
    "curious": "lib/assets/images/emotions/emotions-curious.png",
    "embarrassed": "lib/assets/images/emotions/emotions-embarrassed.png",
    "scared": "lib/assets/images/emotions/emotions-scared.png",
  };

  @override
  void initState() {
    super.initState();
    _updateEmotionData();
    setState(() {});
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateEmotionData();
    setState(() {});
  }

  void _updateEmotionData() {
    final emotionProvider =
        Provider.of<EmotionProvider>(context, listen: false);
    _emotion = emotionProvider.emotion;

    if (_emotion != null) {
      setState(() {
        _selectedTitle = _emotion!.title;
        _selectedName = _emotion!.name;
        _selectedColor =
            Color(int.tryParse(_emotion?.color ?? '0xFFFFFFFF') ?? 0xFFFFFFFF);
        _selectedImagePath = imagePaths[_emotion!.name] ?? "";
      });
    }
  }

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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomTitle(title: "Today"),
        Container(
          margin: const EdgeInsets.only(left: 16, right: 16),
          padding: const EdgeInsets.all(16),
          width: MediaQuery.of(context).size.width * 1,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.black),
            color: _selectedColor,
          ),
          child: Row(
            children: [
              GestureDetector(
                onTap: _showEmotionBottomSheet,
                child: Container(
                  height: AppThemes.getResponsiveImageSize(context, 50),
                  width: AppThemes.getResponsiveImageSize(context, 50),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.black,
                  ),
                  child: _selectedImagePath.isEmpty
                      ? const Icon(
                          Icons.question_mark,
                          color: Colors.white,
                        )
                      : Image.asset(_selectedImagePath),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _selectedImagePath.isEmpty
                          ? "Start selecting what you feel."
                          : "Your word of the day is $_selectedTitle",
                      style: TextStyle(
                        fontSize: AppThemes.getResponsiveFontSize(context, 16),
                        fontFamily: "Jua",
                      ),
                    ),
                    Text(
                      _selectedImagePath.isEmpty
                          ? "Click the question mark to choose an emotion"
                          : "Seems like you are $_selectedName. Share what you feel in the journal.",
                      style: TextStyle(
                        fontSize: AppThemes.getResponsiveFontSize(context, 12),
                        fontFamily: "RethinkSans",
                      ),
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

class Emotion extends StatefulWidget {
  final String imagePath;
  final String title;
  final String name;
  final Color color;
  final Function(String, String, Color, String) onSelect;

  const Emotion({
    super.key,
    required this.title,
    required this.name,
    required this.imagePath,
    required this.color,
    required this.onSelect,
  });

  @override
  State<Emotion> createState() => _EmotionState();
}

class _EmotionState extends State<Emotion> {
  final EmotionController emotionController = EmotionController();
  final DailyEntryController dailyEntryController = DailyEntryController();

  Future<void> _updateEmotion(String title) async {
    EmotionModel? updatedEmotion = await emotionController.getEmotion(title);

    if (mounted) {
      Provider.of<EmotionProvider>(context, listen: false)
          .setEmotion(updatedEmotion);

      DailyEntryModel? dailyEntry =
          Provider.of<DailyEntryProvider>(context, listen: false).dailyEntry;

      // DailyEntry should never be null because an entry
      // will be created in the breather screen if so.
      // The provider will then have that fresh entry.
      // debugPrint("emotion selector updatedEmotion: ${updatedEmotion.title}");
      debugPrint("emotion selector daily entry emotion: $dailyEntry");
      debugPrint("emotion selector: ${dailyEntry!.emotion!.title}");

      dailyEntry.emotion = updatedEmotion;

      await dailyEntryController.updateEntry(
          dailyEntry, dailyEntry.id.toString());

      if (updatedEmotion != null) {
        updatedEmotion
            .toJson()
            .forEach((key, value) => debugPrint("$key: $value"));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _updateEmotion(widget.title);

        widget.onSelect(
            widget.title, widget.name, widget.color, widget.imagePath);
        Navigator.pop(context);
      },
      child: Column(
        children: [
          Image.asset(
            widget.imagePath,
            width: AppThemes.getResponsiveImageSize(context, 60),
            height: AppThemes.getResponsiveImageSize(context, 60),
          ),
          const SizedBox(height: 8),
          Text(
            widget.title,
            style: TextStyle(
                fontSize: AppThemes.getResponsiveFontSize(context, 10),
                fontFamily: "Jua"),
          ),
          Text(
            "(${widget.name})",
            style: TextStyle(
                fontSize: AppThemes.getResponsiveFontSize(context, 10),
                fontFamily: "Jua"),
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
            style: TextStyle(
                fontSize: AppThemes.getResponsiveFontSize(context, 20),
                fontFamily: "Jua",
                fontWeight: FontWeight.bold),
          ),
          Text(
            "Please select one emotion below.",
            style: TextStyle(
                fontSize: AppThemes.getResponsiveFontSize(context, 12),
                fontFamily: "RethinkSans"),
          ),
          const SizedBox(height: 16),
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
                        imagePath:
                            "lib/assets/images/emotions/emotions-happy.png",
                        color: Color(0xFFF8E9BB),
                        onSelect: (title, name, color, imagePath) {
                          widget.onEmotionSelected(
                              title, name, color, imagePath);
                        },
                      ),
                      Emotion(
                        title: "HUHU",
                        name: "sad",
                        imagePath:
                            "lib/assets/images/emotions/emotions-sad.png",
                        color: Color(0xffe4edff),
                        onSelect: (title, name, color, imagePath) {
                          widget.onEmotionSelected(
                              title, name, color, imagePath);
                        },
                      ),
                      Emotion(
                        title: "GRAH",
                        name: "angry",
                        imagePath:
                            "lib/assets/images/emotions/emotions-angry.png",
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
                        imagePath:
                            "lib/assets/images/emotions/emotions-tired.png",
                        color: Color(0xFFf0ffcd),
                        onSelect: (title, name, color, imagePath) {
                          widget.onEmotionSelected(
                              title, name, color, imagePath);
                        },
                      ),
                      Emotion(
                        title: "WOAH",
                        name: "energetic",
                        imagePath:
                            "lib/assets/images/emotions/emotions-energetic.png",
                        color: Color(0xFFffdca0),
                        onSelect: (title, name, color, imagePath) {
                          widget.onEmotionSelected(
                              title, name, color, imagePath);
                        },
                      ),
                      Emotion(
                        title: "MEH",
                        name: "neutral",
                        imagePath:
                            "lib/assets/images/emotions/emotions-neutral.png",
                        color: Color(0xFFfdf1de),
                        onSelect: (title, name, color, imagePath) {
                          widget.onEmotionSelected(
                              title, name, color, imagePath);
                        },
                      ),
                      Emotion(
                        title: "YIE",
                        name: "in love",
                        imagePath:
                            "lib/assets/images/emotions/emotions-love.png",
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
                        imagePath:
                            "lib/assets/images/emotions/emotions-curious.png",
                        color: Color(0xFFcffdf8),
                        onSelect: (title, name, color, imagePath) {
                          widget.onEmotionSelected(
                              title, name, color, imagePath);
                        },
                      ),
                      Emotion(
                        title: "WOMP",
                        name: "embarrassed",
                        imagePath:
                            "lib/assets/images/emotions/emotions-embarrassed.png",
                        color: Color(0xFFffc4c4),
                        onSelect: (title, name, color, imagePath) {
                          widget.onEmotionSelected(
                              title, name, color, imagePath);
                        },
                      ),
                      Emotion(
                        title: "AAA",
                        name: "scared",
                        imagePath:
                            "lib/assets/images/emotions/emotions-scared.png",
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
