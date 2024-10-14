import 'package:flutter/material.dart';
import 'customThemes.dart';
import 'package:intl/intl.dart';

// TODO: Refactor in a way that each date would store its state
class ScrollableCalendar extends StatefulWidget {
  final DateTime initialDate;
  final Function(DateTime) onDateSelected;

  const ScrollableCalendar({
    super.key,
    required this.initialDate,
    required this.onDateSelected,
  });

  @override
  State<ScrollableCalendar> createState() => _ScrollableCalendarState();
}

class _ScrollableCalendarState extends State<ScrollableCalendar> {
  late ScrollController _scrollController;
  late int _selectedIndex;
  List<DateTime> _dates = [];
  int _daysToGenerate = 365;
  final int _threshold = 30;
  // ignore: unused_field
  bool _isInitialJump = true;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _dates = _generateDates(widget.initialDate, _daysToGenerate);
    _scrollController.addListener(_scrollListener);
    _selectedIndex = _findInitialIndex(widget.initialDate);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _jumpToSelectedDate();
    });
  }

  @override
  void didUpdateWidget(ScrollableCalendar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialDate != widget.initialDate) {
      _updateSelectedDate(widget.initialDate);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  List<DateTime> _generateDates(DateTime initialDate, int daysToGenerate) {
    final startDate = initialDate.subtract(Duration(days: 30));
    return List.generate(daysToGenerate, (index) {
      return startDate.add(Duration(days: index));
    });
  }

  int _findInitialIndex(DateTime date) {
    return _dates.indexWhere((d) =>
        d.year == date.year && d.month == date.month && d.day == date.day);
  }

  void _updateSelectedDate(DateTime date) {
    final newIndex = _findInitialIndex(date);
    if (newIndex != -1 && newIndex != _selectedIndex) {
      setState(() {
        _selectedIndex = newIndex;
        _isInitialJump = true;
      });
      _jumpToSelectedDate();
    }
  }

  void _jumpToSelectedDate() {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(_selectedIndex * 103.85);
      _isInitialJump = false;
    }
  }

  void _smoothScrollToSelectedDate() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _selectedIndex * 103.85,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - _threshold) {
      setState(() {
        _daysToGenerate += 365;
        _dates.addAll(_generateDates(_dates.last.add(Duration(days: 1)), 365));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: _dates.length,
        itemBuilder: (context, index) {
          final date = _dates[index];
          final isSelected = index == _selectedIndex;
          return DateWidget(
            date: date,
            isSelected: isSelected,
            onTap: () {
              setState(() {
                _selectedIndex = index;
                _isInitialJump = false;
              });
              _smoothScrollToSelectedDate();
              widget.onDateSelected(date);
            },
          );
        },
      ),
    );
  }
}

class DateWidget extends StatelessWidget {
  final DateTime date;
  final bool isSelected;
  final VoidCallback onTap;

  const DateWidget({
    super.key,
    required this.date,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).cardColor
              : Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xff000000)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              DateFormat("MMMM").format(date),
              style: TextStyle(
                fontSize: AppThemes.getResponsiveFontSize(context, 14),
                fontWeight: FontWeight.bold,
                color: isSelected
                    ? Theme.of(context).textTheme.displaySmall?.color
                    : Theme.of(context).textTheme.displayMedium?.color,
                fontFamily: "Jua",
              ),
            ),
            Text(
              DateFormat("dd").format(date),
              style: TextStyle(
                fontSize: AppThemes.getResponsiveFontSize(context, 34),
                fontWeight: FontWeight.bold,
                color: isSelected
                    ? Theme.of(context).textTheme.displaySmall?.color
                    : Theme.of(context).textTheme.displayMedium?.color,
                fontFamily: "Jua",
              ),
            ),
            Text(
              DateFormat("EEEE").format(date),
              style: TextStyle(
                fontSize: AppThemes.getResponsiveFontSize(context, 14),
                color: isSelected
                    ? Theme.of(context).textTheme.displaySmall?.color
                    : Theme.of(context).textTheme.displayMedium?.color,
                fontFamily: "Jua",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
