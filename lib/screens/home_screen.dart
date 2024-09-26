import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
// import '../main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime today = DateTime.now();
  // late String _currentDate;
  // late String _currentDay;

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
    final height = MediaQuery.of(context).size.height;
    final isSmallScreen = width < 450;

    return Material(
      color: const Color.fromRGBO(241, 243, 244, 1),
      child: Center(
        child: Column(
          children: [
            //Intro--something
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
                      )
                    ],
                  ),
                ],
              ),
            ),

            //Calendar
            Container(
              width: width,
              height: height * 0.6,
              alignment: Alignment.center,
              margin: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              child: TableCalendar(
                rowHeight: height * 0.07,
                focusedDay: today,
                firstDay: DateTime(2000, 1, 1),
                lastDay: DateTime.now(),
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
                  defaultDecoration: BoxDecoration(
                      color: const Color(0xFFD6D6D6),
                      shape: BoxShape.circle,
                      border: Border.all(width: 1, color: Colors.black)),
                  weekendDecoration: BoxDecoration(
                      color: const Color(0xFFD6D6D6),
                      shape: BoxShape.circle,
                      border: Border.all(width: 1, color: Colors.black)),
                  selectedTextStyle: const TextStyle(color: Colors.white),
                  weekendTextStyle: const TextStyle(color: Colors.black),
                  todayDecoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    shape: BoxShape.circle,
                  ),
                  todayTextStyle: const TextStyle(color: Colors.white),
                ),
                availableGestures: AvailableGestures.all,
                selectedDayPredicate: (day) => isSameDay(day, today),
                onDaySelected: _onSelectedDay,
                daysOfWeekStyle: DaysOfWeekStyle(
                  weekdayStyle: TextStyle(color: Colors.transparent),
                  weekendStyle: TextStyle(
                      color: Colors.transparent,
                      backgroundColor: Color(0xff2d2d2d)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
