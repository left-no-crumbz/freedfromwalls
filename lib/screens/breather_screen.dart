import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
          const EmotionSelectorContainer(),
          const SizedBox(height: 16),
          const Title(title: "Your Journal"),
          const SizedBox(height: 8),
          ScrollableCalendar(initialDate: DateTime.now()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
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
        const Title(title: "Today"),
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
                      ? const Icon(
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

class Title extends StatelessWidget {
  final String title;
  const Title({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, bottom: 8),
      child: Text(
        title,
        style: const TextStyle(fontSize: 12),
      ),
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
          const Text(
            "How do you feel right now?",
            style: const TextStyle(fontSize: 20),
          ),
          const Text(
            "Please select one emotion below.",
            style: const TextStyle(fontSize: 12),
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

class ScrollableCalendar extends StatefulWidget {
  final DateTime initialDate;

  const ScrollableCalendar({Key? key, required this.initialDate})
      : super(key: key);

  @override
  State<ScrollableCalendar> createState() => _ScrollableCalendarState();
}

class _ScrollableCalendarState extends State<ScrollableCalendar> {
  late ScrollController _scrollController;
  late int _selectedIndex;
  List<DateTime> _dates = [];
  int _daysToGenerate = 365;
  int _threshold = 30;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _dates = _generateDates(widget.initialDate, _daysToGenerate);
    _scrollController.addListener(_scrollListener);
    _selectedIndex = 30;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToSelectedDate();
    });
  }

  List<DateTime> _generateDates(DateTime initialDate, int daysToGenerate) {
    return List.generate(daysToGenerate, (index) {
      return initialDate
          .subtract(Duration(days: 30))
          .add(Duration(days: index));
    });
  }

  void _scrollToSelectedDate() {
    _scrollController.animateTo(
        _selectedIndex *
            103.85, // 103.85 is a magic number to make the current date scroll to the middle
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut);
  }

  // unlimited date generator
  void _scrollListener() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - _threshold) {
      setState(() {
        _daysToGenerate += 365;
        _dates.addAll(_generateDates(_dates.last, 365));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      child: ListView.builder(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          itemCount: _dates.length,
          itemBuilder: (context, index) {
            final date = _dates[index];
            final isSelected = index == _selectedIndex;
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = index;
                });
              },
              child: Container(
                width: 100,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xff56537C)
                        : const Color(0xffEFEFEF),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xff000000)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      )
                    ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      DateFormat("MMMM").format(date),
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: isSelected
                              ? const Color(0xffD7D5EE)
                              : const Color(0xff000000)),
                    ),
                    Text(
                      DateFormat("dd").format(date),
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: isSelected
                              ? const Color(0xffD7D5EE)
                              : const Color(0xff000000)),
                    ),
                    Text(
                      DateFormat("EEEE").format(date),
                      style: TextStyle(
                        fontSize: 12,
                        color: isSelected
                            ? const Color(0xffD7D5EE)
                            : const Color(0xff000000),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
