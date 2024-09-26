import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// TODO: Refactor in a way that each date would store its state
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
