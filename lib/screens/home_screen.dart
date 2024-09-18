import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

import '../main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime today = DateTime.now();
  late String _currentDate;
  late String _currentDay;

  @override
  void initState() {
    super.initState();
    _updateTime();
  }

  void _updateTime() {
    final now = DateTime.now();
    final formattedDate = DateFormat('yMMMMd').format(now);
    final formattedDay = DateFormat('EEEE').format(now);

    setState(() {
      _currentDate = formattedDate;
      _currentDay = formattedDay;
    });
  }

  void _onSelectedDay(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    /// Width of the screen
    final height = MediaQuery.of(context).size.height;

    /// Height of the screen
    final isSmallScreen = width < 450;

    /// Checks if the screen is small

    return Material(
      color: const Color.fromRGBO(241, 243, 244, 1),
      child: Center(
        child: ListView(
          children: <Widget>[
            ///Intro--something
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
                            'Your Virtual Diary. Virtual Therapy. Virtual Company.',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: isSmallScreen ? 8 : 10,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {});
                            },
                            icon: const Icon(
                              Icons.settings,
                              color: Colors.black,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {});
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Expanded(
                    child: Text(''),
                  ),
                  Text(
                    _currentDate,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: isSmallScreen ? 12 : 14,
                    ),
                  ),
                  Text(
                    _currentDay,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: isSmallScreen ? 12 : 14,
                    ),
                  ),
                ],
              ),
            ),

            ///Calendar
            Container(
              width: width,
              height: 360,
              alignment: Alignment.center,
              margin: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  width: 1.0,
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: TableCalendar(
                focusedDay: today,
                firstDay: DateTime(2000, 1, 1),
                lastDay: DateTime(2050, 1, 1),
                headerStyle: const HeaderStyle(
                  titleCentered: true,
                  formatButtonVisible: false,
                  headerMargin: EdgeInsets.only(bottom: 10),
                ),
                calendarStyle: CalendarStyle(
                  selectedDecoration: const BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                  ),
                  selectedTextStyle: const TextStyle(color: Colors.white),
                  todayDecoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    shape: BoxShape.circle,
                  ),
                  todayTextStyle: const TextStyle(color: Colors.white),
                  weekendTextStyle: const TextStyle(color: Colors.red),
                ),
                availableGestures: AvailableGestures.all,
                selectedDayPredicate: (day) => isSameDay(day, today),
                onDaySelected: _onSelectedDay,
              ),
            ),

            ///Button to Breather Page
            Container(
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              child: ElevatedButton(
                  onPressed: () {
                    context
                        .findAncestorStateOfType<AppStateStates>()
                        ?.onBottomNavItemTap(2);
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: EdgeInsets.all(20),
                      backgroundColor: Color(0xff2d2d2d)),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("lib/assets/images/emotions-happy.png",
                            fit: BoxFit.cover),
                        const Text(
                          "View your journal entry today!",
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        )
                      ],
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}

Widget buildJournalEntryButton(BuildContext context, Color color, String text) {
  return SizedBox(
    height: 70,
    child: Card(
      color: const Color.fromRGBO(66, 62, 61, 1),
      margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      child: Center(
        child: ListTile(
          leading: Icon(
            Icons.circle,
            color: color,
          ),
          title: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    ),
  );
}
