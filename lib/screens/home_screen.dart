import 'package:flutter/material.dart';
import 'package:freedfromwalls/assets/widgets/customThemes.dart';
import 'package:freedfromwalls/screens/settings_screen.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Calendar
  DateTime today = DateTime.now();
  late String _currentMonth;
  late String _currentYear;
  DateTime firstDayOfMonth = DateTime(DateTime.now().year, DateTime.now().month, 1);

  //Emotions
  late Map<String, dynamic> _mostFreqMood; //Map of the most frequent mood
  late String _selectedTitle;
  late String _selectedName;
  late String _selectedImagePath;
  late Color _selectedColor;

  //Emotions with each descriptions
  final List<Map<String, dynamic>> _emotions = [
    {
      'title': 'YAY',
      'name': 'happy',
      'imagePath': 'lib/assets/images/emotions-happy.png',
      'color': Color(0xFFF8E9BB),
    },
    {
      'title': 'HUHU',
      'name': 'sad',
      'imagePath': 'lib/assets/images/emotions-sad.png',
      'color': Color(0xffe4edff),
    },
    {
      'title': 'GRAH',
      'name': 'angry',
      'imagePath': 'lib/assets/images/emotions-angry.png',
      'color': Color(0xFFfdb9b8),
    },
    {
      'title': 'SIGH',
      'name': 'tired',
      'imagePath': 'lib/assets/images/emotions-tired.png',
      'color': Color(0xFFf0ffcd),
    },
    {
      'title': 'WOAH',
      'name': 'energetic',
      'imagePath': 'lib/assets/images/emotions-energetic.png',
      'color': Color(0xFFffdca0),
    },
    {
      'title': 'MEH',
      'name': 'neutral',
      'imagePath': 'lib/assets/images/emotions-neutral.png',
      'color': Color(0xFFfdf1de),
    },
    {
      'title': 'YIE',
      'name': 'in love',
      'imagePath': 'lib/assets/images/emotions-love.png',
      'color': Color(0xFFffdbe7),
    },
    {
      'title': 'UHM',
      'name': 'curious',
      'imagePath': 'lib/assets/images/emotions-curious.png',
      'color': Color(0xFFcffdf8),
    },
    {
      'title': 'WOMP',
      'name': 'embarrassed',
      'imagePath': 'lib/assets/images/emotions-embarrassed.png',
      'color': Color(0xFFffc4c4),
    },
    {
      'title': 'AAA',
      'name': 'scared',
      'imagePath': 'lib/assets/images/emotions-scared.png',
      'color': Color(0xFFffccab),
    },
  ];

  // Mood icons for specific dates
  Map<DateTime, String> userMoods = {
    DateTime(2024, 9, 20): 'lib/assets/images/emotions-curious.png',
    DateTime(2024, 9, 15): 'lib/assets/images/emotions-love.png',
    DateTime(2024, 9, 21): 'lib/assets/images/emotions-sad.png',
    DateTime(2024, 9, 22): 'lib/assets/images/emotions-angry.png',
    DateTime(2024, 9, 23): 'lib/assets/images/emotions-happy.png',
    DateTime(2024, 9, 24): 'lib/assets/images/emotions-happy.png',
    // Add more dates and mood images as needed
  };

  @override
  void initState() {
    super.initState();
    _updateTime();
    _findMostFrequentMood();
  }

  //Updates the month and year real time
  void _updateTime() {
    final now = DateTime.now();
    final formattedMonth = DateFormat('MMMM').format(now);
    final formattedYear = DateFormat('y').format(now);

    setState(() {
      _currentMonth = formattedMonth;
      _currentYear = formattedYear;
    });
  }

  // Find the most frequent emotion
  void _findMostFrequentMood() {
    Map<String, int> moodFrequency = {};

    userMoods.forEach((date, moodImagePath) {
      moodFrequency[moodImagePath] = (moodFrequency[moodImagePath] ?? 0) + 1;
    });

    String? mostFrequentImagePath;
    int highestFrequency = 0;

    moodFrequency.forEach((moodImagePath, frequency) {
      if (frequency > highestFrequency) {
        mostFrequentImagePath = moodImagePath;
        highestFrequency = frequency;
      }
    });

    // Find the emotion details based on the most frequent image path
    _mostFreqMood = _emotions.firstWhere(
          (emotion) => emotion['imagePath'] == mostFrequentImagePath,
      orElse: () => {
        'title': '',
        'name': '',
        'imagePath': '',
        'color': Colors.white, // Default fallback color
      },
    );

    setState(() {
      _selectedColor = _mostFreqMood['color'];
      _selectedImagePath = _mostFreqMood['imagePath'];
      _selectedName = _mostFreqMood['name'];
      _selectedTitle = _mostFreqMood['title'];
    });
  }


  //Generate days for the 5-grid calendar
  List<DateTime> _generateDaysInMonth(DateTime date) {
    List<DateTime> days = [];
    DateTime firstDayOfMonth = DateTime(date.year, date.month, 1);

    for (int i = 0; i < today.day; i++) {
      days.add(firstDayOfMonth.add(Duration(days: i)));
    }

    return days;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    // Days of the current month
    List<DateTime> daysInMonth = _generateDaysInMonth(today);

    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Center(
        child: Column(
          children: [
            // Intro section
            Container(
              width: width,
              height: height * 0.10,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Home',
                            style: TextStyle(
                              color: Theme.of(context).textTheme.bodyLarge?.color,
                              fontWeight: FontWeight.bold,
                              fontSize: AppThemes.getResponsiveFontSize(context, 16),
                            ),
                          ),
                          Text(
                            'Your Virtual Diary, Your Virtual Company.',
                            style: TextStyle(
                              color: Theme.of(context).textTheme.bodyLarge?.color,
                              fontSize: AppThemes.getResponsiveFontSize(context, 10),
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SettingsPage(),
                            ),
                          );
                        },
                        icon: Icon(Icons.settings),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Container(
              margin: const EdgeInsets.only(left: 16, right: 16, bottom: 18),
              padding: const EdgeInsets.all(16),
              width: MediaQuery.of(context).size.width * 1,
              height: height * 0.12,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.black),
                  color: _selectedColor,
              ),
              child: Row(
                children: [
                  Container(
                    height: AppThemes.getResponsiveImageSize(context, 50),
                    width: AppThemes.getResponsiveImageSize(context, 50),
                    child: _selectedImagePath.isEmpty
                        ? const Icon(
                      Icons.question_mark,
                      color: Colors.white,
                    )
                        : Image.asset(_selectedImagePath),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
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
                              ? "Why don't you feel anything..."
                              : "Your word of the month is $_selectedTitle",
                          style: TextStyle(fontSize: AppThemes.getResponsiveFontSize(context, 14)),
                        ),
                        Text(
                          _selectedTitle.isEmpty
                              ? "Hopefully, you're still alive"
                              : "Seems like you are $_selectedName during the month of $_currentMonth.",
                          style: TextStyle(fontSize: AppThemes.getResponsiveFontSize(context, 10)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Custom 5-Day per row Calendar Grid
            Column(
              children: [
                Text(
                  '$_currentMonth',
                  style: TextStyle(
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                      fontSize: AppThemes.getResponsiveFontSize(context, 16),
                      fontWeight: FontWeight.bold
                  ),
                ),
                Text(
                  '$_currentYear',
                  style: TextStyle(
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                      fontSize: AppThemes.getResponsiveFontSize(context, 14)
                  ),
                ),

                SizedBox(
                  height: height * 0.02,
                ),

                //5-Day Calendar
                Container(
                  height: height * 0.5,
                  margin: EdgeInsets.symmetric(horizontal: width * 0.05),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      childAspectRatio: 1.5,
                      mainAxisSpacing: height * 0.015,
                    ),
                    itemCount: daysInMonth.length,
                    itemBuilder: (context, index) {
                      DateTime date = daysInMonth[index];

                      // Normalize the date to remove the time part
                      DateTime normalizedDate = DateTime(date.year, date.month, date.day);

                      // Check if a mood exists for the current date
                      bool hasMood = userMoods.containsKey(normalizedDate);

                      return Container(
                          margin: EdgeInsets.all(4.0),
                          width: width * 0.12,
                          height: width * 0.12,
                          decoration: BoxDecoration(
                            color: isSameDay(today, date) ? Theme.of(context).cardColor : Theme.of(context).primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: hasMood ? Image.asset(
                              userMoods[normalizedDate]!,
                              width: width * 0.12,
                              height: width * 0.12,
                              fit: BoxFit.cover,
                            )
                                : Text(
                                  '${date.day}',
                                  style: TextStyle(
                                      color: isSameDay(today, date) ? Theme.of(context).textTheme.displaySmall?.color : Theme.of(context).textTheme.displayMedium?.color,
                                      fontSize:  AppThemes.getResponsiveFontSize(context, 12),
                                      fontWeight: FontWeight.bold,
                                  ),
                                ),
                          ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to check if two dates are the same
  bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
