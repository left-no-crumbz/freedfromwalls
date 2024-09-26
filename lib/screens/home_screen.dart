import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime today = DateTime.now();
  late String _currentMonth;
  late String _currentYear;
  DateTime firstDayOfMonth = DateTime(DateTime.now().year, DateTime.now().month, 1);

  @override
  void initState() {
    super.initState();
    _updateTime();
  }

  void _updateTime() {
    final now = DateTime.now();
    final formattedMonth = DateFormat('MMMM').format(now);
    final formattedYear = DateFormat('y').format(now);

    setState(() {
      _currentMonth = formattedMonth;
      _currentYear = formattedYear;
    });
  }

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
    final isSmallScreen = width < 450;

    // Days of the current month
    List<DateTime> daysInMonth = _generateDaysInMonth(today);

    // Mood icons for specific dates
    Map<DateTime, String> userMoods = {
      DateTime(2024, 9, 20): 'lib/assets/images/emotions-angry.png',
      DateTime(2024, 9, 15): 'lib/assets/images/emotions-love.png',
      // Add more dates and mood images as needed
    };

    return Material(
      color: const Color.fromRGBO(241, 243, 244, 1),
      child: Center(
        child: Column(
          children: [
            // Intro section
            Container(
              width: width,
              height: isSmallScreen ? height * 0.15 : height * 0.17,
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
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: isSmallScreen ? 16 : 20,
                            ),
                          ),
                          Text(
                            'Your Virtual Diary, Your Virtual Company.',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: isSmallScreen ? 8 : 10,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.settings),
                      ),
                    ],
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
                      color: Colors.black,
                      fontSize: height * 0.02
                  ),
                ),
                Text(
                  '$_currentYear',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: height * 0.015
                  ),
                ),

                SizedBox(
                  height: height * 0.02,
                ),

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
                            color: isSameDay(today, date) ? Colors.black : Colors.grey[300],
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
                                    color: isSameDay(today, date) ? Colors.white : Colors.black,
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
