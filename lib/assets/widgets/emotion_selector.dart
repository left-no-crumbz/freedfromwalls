import 'package:flutter/material.dart';
import 'package:freedfromwalls/controllers/emotion_controller.dart';
import '../../models/user.dart';
import '../../providers/daily_entry_provider.dart';
import '../../providers/emotion_provider.dart';
import '../../controllers/daily_entry_controller.dart';
import '../../models/daily_entry.dart';
import '../../providers/user_provider.dart';
import './custom_title.dart';
import 'customThemes.dart';
import 'package:provider/provider.dart';
import '../../models/emotion.dart';

class EmotionSelectorContainer extends StatefulWidget {
  final EmotionModel? emotion;
  final DateTime selectedDate;
  const EmotionSelectorContainer(
      {super.key, this.emotion, required this.selectedDate});

  @override
  State<EmotionSelectorContainer> createState() =>
      _EmotionSelectorContainerState();
}

class _EmotionSelectorContainerState extends State<EmotionSelectorContainer> {
  String? _selectedTitle;
  String? _selectedName;
  String _selectedImagePath = "";
  Color _selectedColor = Colors.white;
  final DailyEntryController _controller = DailyEntryController();

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
  }

  @override
  void didUpdateWidget(covariant EmotionSelectorContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.emotion != widget.emotion) {
      _updateEmotionData();
    }
  }

  bool get _isEditable {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final selectedDate = DateTime(widget.selectedDate.year,
        widget.selectedDate.month, widget.selectedDate.day);
    return selectedDate.isAtSameMomentAs(today) || selectedDate.isBefore(today);
  }

  bool get _isEntryExisting {
    final List<DailyEntryModel> entries =
        Provider.of<DailyEntryProvider>(context, listen: false).entries;

    final selectedDate = DateTime(widget.selectedDate.year,
        widget.selectedDate.month, widget.selectedDate.day);

    debugPrint("Selected Date: $selectedDate");

    // Iterate through the entries and compare the createdDate with selectedDate
    for (var entry in entries) {
      final createdDate = DateTime.parse("${entry.createdAt}".substring(0, 10));

      debugPrint("Created Date: $createdDate");

      if (createdDate == selectedDate) {
        return true; // Return true if a match is found
      }
    }
    return false; // Return false if no match is found
  }

  void _updateEmotionData() {
    final emotion = widget.emotion;

    if (emotion != null) {
      setState(() {
        _selectedTitle = emotion.title;
        _selectedName = emotion.name;
        _selectedColor = Color(int.tryParse(emotion.color) ?? 0xFFFFFFFF);
        _selectedImagePath = imagePaths[emotion.name] ?? "";
      });
    } else {
      setState(() {
        _selectedTitle = null;
        _selectedName = null;
        _selectedColor = Colors.white;
        _selectedImagePath = "";
      });
    }
  }

  void _showEmotionBottomSheet() {
    debugPrint("$_isEditable");
    if (!_isEditable) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Cannot edit emotions for future dates.")),
      );
      return;
    } else if (_isEntryExisting == false) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Cannot edit emotions for non-existing entries.")),
      );
      return;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) => EmotionBottomSheet(
        selectedDate: widget.selectedDate,
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
  final DateTime selectedDate;

  const Emotion({
    super.key,
    required this.title,
    required this.name,
    required this.imagePath,
    required this.color,
    required this.onSelect,
    required this.selectedDate,
  });

  @override
  State<Emotion> createState() => _EmotionState();
}

class _EmotionState extends State<Emotion> {
  final EmotionController emotionController = EmotionController();
  final DailyEntryController dailyEntryController = DailyEntryController();

  @override
  void initState() {
    super.initState();
    debugPrint("Emotion widget mounted");
  }

  @override
  void dispose() {
    debugPrint("Emotion widget disposed");
    super.dispose();
  }

  // TODO: Implement getTodayEntry
  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  DailyEntryModel _getEntryForDate(DateTime date) {
    final entries =
        Provider.of<DailyEntryProvider>(context, listen: false).entries;

    return entries.firstWhere(
      (entry) => _isSameDay(entry.createdAt ?? date, date),
      orElse: () => DailyEntryModel(
        user: Provider.of<UserProvider>(context, listen: false).user!,
        journalEntry: '',
        emotion: null,
        additionalNotes: [],
        createdAt: null,
        updatedAt: null,
      ),
    );
  }

  Future<void> _updateEmotion(String title) async {
    EmotionModel? updatedEmotion = await emotionController.getEmotion(title);

    Provider.of<EmotionProvider>(context, listen: false)
        .setEmotion(updatedEmotion);

    DailyEntryModel? dailyEntry = _getEntryForDate(widget.selectedDate);

    // DailyEntry should never be null because an entry
    // will be created in the breather screen if so.
    // The provider will then have that fresh entry.
    // debugPrint("emotion selector updatedEmotion: ${updatedEmotion.title}");

    // final entries =
    //     Provider.of<DailyEntryProvider>(context, listen: false).entries;
    //
    // debugPrint("$entries");
    // entries.forEach((entry) => debugPrint("${entry.toJson()}"));

    if (dailyEntry != null) {
      debugPrint("emotion selector daily entry emotion: $dailyEntry");
      debugPrint("emotion selector: ${dailyEntry.emotion?.title}");
      debugPrint(
          "emotion selector daily entry updated emotion: ${dailyEntry.emotion?.title}");
      debugPrint("${dailyEntry.id}");
      debugPrint("${dailyEntry.toJson()}");
    }

    // This is not needed as an entry will be created on page load now.
    // if (dailyEntry?.id == null) {
    //   await dailyEntryController.addEntry(dailyEntry!);
    // }

    dailyEntry?.emotion = updatedEmotion;
    // This breaks when there is no daily entry in the backend because by then there is no id yet.
    try {
      await emotionController.updateEmotion(
          dailyEntry!, dailyEntry.id.toString());
    } catch (e) {
      throw Exception("$e");
    }

    if (updatedEmotion != null) {
      updatedEmotion
          .toJson()
          .forEach((key, value) => debugPrint("$key: $value"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await _updateEmotion(widget.title);

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
  final DateTime selectedDate;
  const EmotionBottomSheet({
    super.key,
    required this.onEmotionSelected,
    required this.selectedDate,
  });

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
                        selectedDate: widget.selectedDate,
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
                        selectedDate: widget.selectedDate,
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
                        selectedDate: widget.selectedDate,
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
                        selectedDate: widget.selectedDate,
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
                        selectedDate: widget.selectedDate,
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
                        selectedDate: widget.selectedDate,
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
                        selectedDate: widget.selectedDate,
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
                        selectedDate: widget.selectedDate,
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
                        selectedDate: widget.selectedDate,
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
                        selectedDate: widget.selectedDate,
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
