import 'package:flutter/material.dart';
import 'package:freedfromwalls/assets/widgets/customThemes.dart';
import 'package:freedfromwalls/screens/settings_screen.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../assets/widgets/title_description.dart';
import '../controllers/daily_entry_controller.dart';
import '../models/daily_entry.dart';
import '../models/user.dart';
import '../providers/daily_entry_provider.dart';
import '../providers/user_provider.dart';
import '../models/emotion.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Others
  bool _isLoading = true;
  final DailyEntryController _controller = DailyEntryController();

  //Calendar
  DateTime today = DateTime.now();
  late String _currentMonth;
  late String _currentYear;
  DateTime firstDayOfMonth = DateTime(DateTime.now().year, DateTime.now().month, 1);

  //Emotions
  List<DailyEntryModel> _entriesMonth = [];
  List<EmotionModel> _emotions = [];
  late Map<String, dynamic> _mostFreqMood;
  String _selectedTitle = '';
  String _selectedName = '';
  String _selectedImagePath = '';
  Color _selectedColor = Colors.white;

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

  //Emotions with each descriptions
  final List<Map<String, dynamic>> _usedEmotions = [];

  // Mood icons for specific dates
  Map<DateTime, String> userMoods = {};

  @override
  void initState() {
    super.initState();
    _updateTime();
    _fetchMonthlyEntries();
  }

  void _populateUserMoods() {
    // Clear the existing user moods map
    userMoods.clear();

    for (var entry in _entriesMonth) {
      // Assuming `entry.createdAt` gives you the DateTime of the entry
      DateTime? date = entry.createdAt; // Adjust based on your model

      if (date != null) {
        // Normalize the date to remove the time part
        DateTime normalizedDate = DateTime(date.year, date.month, date.day);

        // Get the emotion name from the entry
        String emotionName = entry.emotion?.name ?? '';

        // Use imagePaths to get the corresponding image path
        String? imagePath = imagePaths[emotionName];

        if (imagePath != null) {
          // Map the normalized date to the emotion image path
          userMoods[normalizedDate] = imagePath;
        }
      }
    }
  }

  void _populateUsedEmotions() {
    // Clear the existing used emotions list
    _usedEmotions.clear();

    // Iterate through each unique emotion in _emotions
    for (var emotion in _emotions) {
      // Get the name of the emotion
      String emotionName = emotion.name;

      // Check if the emotion name exists in the imagePaths map
      if (imagePaths.containsKey(emotionName)) {
        // Check if this emotion is already in the _usedEmotions list
        bool alreadyExists = _usedEmotions.any((e) => e['name'] == emotionName);
        if (alreadyExists) {
          continue; // Skip this emotion if it already exists
        }

        // Create a new map for the emotion details
        Map<String, dynamic> emotionDetails = {
          'title': emotion.title,
          'name': emotionName,
          'imagePath': imagePaths[emotionName],
          'color': int.parse(emotion.color.toString()),
        };

        // Add the details to _usedEmotions
        _usedEmotions.add(emotionDetails);
      }
    }

    print(_usedEmotions);
  }


  // Fetch entries on this month
  Future<void> _fetchMonthlyEntries() async {
    setState(() {
      _isLoading = true;
    });

    UserModel? user = Provider.of<UserProvider>(context, listen: false).user;

    List<DailyEntryModel> fetchedEntries = await  _controller.fetchThisMonthEntries(user!.id.toString());

    fetchedEntries.forEach((item) => debugPrint("Fetched item: ${item.id} - ${item.createdAt} - ${item.emotion}"));

    for (int i = 0; i < fetchedEntries.length; i++) {
      DailyEntryModel currentEntry = fetchedEntries[i];
      EmotionModel? emotion = currentEntry.emotion;

      if (emotion != null) {
        if (_emotions.contains(emotion)) {
          continue;
        } else {
          _emotions.add(emotion);
        }
      }
    }

    setState(() {
      _entriesMonth = fetchedEntries;
    });

    // Fetch moods of user and used emotion
    _populateUserMoods();
    _populateUsedEmotions();

    // Find most freq mood
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

  // Find the most frequent emotion for the current month
  void _findMostFrequentMood() {
    Map<String, int> moodFrequency = {};
    DateTime now = DateTime.now(); // Current date

    // Filter moods to include only those from the current month
    userMoods.forEach((date, moodImagePath) {
      if (date.year == now.year && date.month == now.month) {
        moodFrequency[moodImagePath] = (moodFrequency[moodImagePath] ?? 0) + 1;
      }
    });

    String? mostFrequentImagePath;
    int highestFrequency = 0;

    // Find the most frequent mood image path
    moodFrequency.forEach((moodImagePath, frequency) {
      if (frequency > highestFrequency) {
        mostFrequentImagePath = moodImagePath;
        highestFrequency = frequency;
      }
    });

    // Find the emotion details based on the most frequent image path
    _mostFreqMood = _usedEmotions.firstWhere(
          (emotion) => emotion['imagePath'] == mostFrequentImagePath,
      orElse: () => {
        'title': '',
        'name': '',
        'imagePath': '',
        'color': Colors.white, // Default fallback color
      },
    );

    print(_mostFreqMood);

    // Update the state with the most frequent mood details
    setState(() {
      _selectedColor = Color(_mostFreqMood['color']);
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
    UserModel? user = Provider.of<UserProvider>(context, listen: false).user;

    // Days of the current month
    List<DateTime> daysInMonth = _generateDaysInMonth(today);

    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Center(
        child: ListView(
          children: [
            // Intro section
            Container(
              width: width,
              height: height * 0.14,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const TitleDescription(title: "Home", description: "Your Virtual Diary, Your Virtual Company."),
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
                        color: Colors.black,
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

                      // Check if an entry exists for the current date and if it has a mood
                      // Check if an entry exists for the current date and if it has a mood
                      DailyEntryModel entryForDate = _entriesMonth.firstWhere(
                            (entry) => entry.createdAt != null && isSameDay(entry.createdAt!, normalizedDate),
                        orElse: () => DailyEntryModel(
                          id: -1,
                          user: user!,
                          emotion: null,
                          journalEntry: '',
                          additionalNotes: [],
                          createdAt: normalizedDate,
                          updatedAt: null,
                        ),
                      );

                      bool hasMood = entryForDate.emotion != null;

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
                              imagePaths[entryForDate!.emotion!.name]!,
                              width: width * 0.10,
                              height: width * 0.10,
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