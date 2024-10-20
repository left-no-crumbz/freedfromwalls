import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import '../controllers/daily_entry_controller.dart';
import '../models/daily_entry.dart';
import '../models/user.dart';
import '../providers/user_provider.dart';
import '../providers/emotion_provider.dart';
import '../providers/daily_entry_provider.dart';
import '../assets/widgets/scrollable_calendar.dart';
import '../assets/widgets/emotion_selector.dart';
import '../assets/widgets/journal_entry_container.dart';
import '../assets/widgets/title_description.dart';
import './journal_entry.dart';

class BreatherPage extends StatefulWidget {
  const BreatherPage({super.key});

  @override
  BreatherPageState createState() => BreatherPageState();
}

class BreatherPageState extends State<BreatherPage> {
  final DailyEntryController _controller = DailyEntryController();
  static final DateTime _now = DateTime.now();
  static final DateTime _currentDate =
      DateTime(_now.year, _now.month, _now.day);
  final ValueNotifier<DateTime> _selectedDate = ValueNotifier(_currentDate);
  late Future<void> _entriesFuture;
  @override
  void initState() {
    super.initState();
    _entriesFuture = _loadEntries();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // DANGEROUS!
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _updateCurrentEntry(_selectedDate.value);
    });
  }

  void _updateCurrentEntry(DateTime date) {
    final entry = _getEntryForDate(date);
    Provider.of<DailyEntryProvider>(context, listen: false)
        .setCurrentEntry(entry);
    Provider.of<EmotionProvider>(context, listen: false)
        .setEmotion(entry.emotion);
  }

  bool get _isEntryExisting {
    final List<DailyEntryModel> entries =
        Provider.of<DailyEntryProvider>(context, listen: false).entries;

    debugPrint("Selected Date: ${_selectedDate.value}");

    // Iterate through the entries and compare the createdDate with selectedDate
    for (var entry in entries) {
      final createdDate = DateTime.parse("${entry.createdAt}".substring(0, 10));

      debugPrint("Created Date: $createdDate");

      if (createdDate == _selectedDate.value) {
        return true; // Return true if a match is found
      }
    }
    return false; // Return false if no match is found
  }

  // FIXME: Hay may bug na naman

  Future<void> _loadEntries() async {
    // create an entry for today
    DateTime now = DateTime.now();
    DateTime currentDate = DateTime(now.year, now.month, now.day);

    try {
      UserModel? user = Provider.of<UserProvider>(context, listen: false).user;

      // Upon load of the breather screen, this will fetch all the entries
      final entries = await _controller.fetchEntries(user!.id.toString());

      if (mounted) {
        // This will update the entries in the Provider
        Provider.of<DailyEntryProvider>(context, listen: false)
            .setEntries(entries);
      }
      //  This takes the entry of the current date.
      //  It relies on the values of the Provider
      DailyEntryModel dailyEntry = _getEntryForDate(currentDate);

      debugPrint("${dailyEntry.toJson()}");
      // If the entry id is null, which means it hasn't been sent to the backend,
      // then send a POST request to it
      if (dailyEntry.id == null) {
        try {
          await _controller.addEntry(dailyEntry);
          // Makes sure that our entries are always updated
          final entries = await _controller.fetchEntries(user.id.toString());
          if (mounted) {
            debugPrint("Di siguro umaabot dito");

            // As well as our provider
            Provider.of<DailyEntryProvider>(context, listen: false)
                .setEntries(entries);
          }
        } catch (e) {
          debugPrint("ERROR: $e");
        }
        _updateCurrentEntry(currentDate);
      }
    } catch (e) {
      debugPrint("Error loading entries: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Error: Fail to load entries."),
        ));
      }
    }
  }

  DailyEntryModel _getEntryForDate(DateTime date) {
    // _loadEntries();

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

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  void _updateJournalEntry(
      String entry, DateTime creationDate, DateTime editedDate) {
    final updatedEntry = Provider.of<DailyEntryProvider>(context, listen: false)
        .currentEntry
        ?.copyWith(
          journalEntry: entry,
          updatedAt: editedDate,
        );
    if (updatedEntry != null) {
      Provider.of<DailyEntryProvider>(context, listen: false)
          .updateEntry(updatedEntry);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _entriesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          return RefreshIndicator(
            onRefresh: () async {
              setState(() {
                _entriesFuture = _loadEntries();
              });
            },
            child: ListView(
              children: [
                const TitleDescription(
                  title: "Breather",
                  description: "Take a pause for a moment",
                ),
                ValueListenableBuilder<DateTime>(
                  valueListenable: _selectedDate,
                  builder: (context, date, child) {
                    final entry = _getEntryForDate(date);

                    return EmotionSelectorContainer(
                      emotion: entry.emotion,
                      selectedDate: date,
                    );
                  },
                ),
                const SizedBox(height: 16),
                const Title(title: "Your Journal"),
                const SizedBox(height: 8),
                ValueListenableBuilder<DateTime>(
                  valueListenable: _selectedDate,
                  builder: (context, date, child) {
                    return ScrollableCalendar(
                      initialDate: date,
                      onDateSelected: (newDate) {
                        _selectedDate.value = newDate;
                      },
                    );
                  },
                ),
                const SizedBox(height: 16),
                ValueListenableBuilder<DateTime>(
                  valueListenable: _selectedDate,
                  builder: (context, date, child) {
                    final entry = _getEntryForDate(date);
                    return JournalEntryContainer(
                      journalEntry: entry.journalEntry,
                      creationDate: (entry.journalEntry.isNotEmpty ||
                              entry.emotion != null)
                          ? entry.createdAt
                          : null,
                      editedDate: (entry.journalEntry.isNotEmpty ||
                              entry.emotion != null)
                          ? entry.updatedAt
                          : null,
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
        shape: const CircleBorder(),
        onPressed: () {
          debugPrint("${_selectedDate.value}");
          DateTime now = DateTime.now();
          DateTime currentDate = DateTime(now.year, now.month, now.day);
          DateTime selectedDateOnly = DateTime(_selectedDate.value.year,
              _selectedDate.value.month, _selectedDate.value.day);
          debugPrint("$currentDate");
          if (selectedDateOnly.isAfter(currentDate)) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Cannot add future entries."),
            ));
          } else if (_isEntryExisting == false) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Cannot add to non-existing entries."),
            ));
          } else {
            final entry = _getEntryForDate(_selectedDate.value);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => JournalEntryScreen(
                  getCurrentTime: () => DateTime.now(),
                  onJournalEntryChanged: _updateJournalEntry,
                  initialEntry: entry.journalEntry,
                  initialCreationDate: entry.createdAt,
                  initialEditedDate: entry.updatedAt,
                  onUpdate: _loadEntries,
                  selectedDate: _selectedDate.value,
                ),
              ),
            );
          }
        },
        child: Icon(Provider.of<DailyEntryProvider>(context)
                    .currentEntry
                    ?.journalEntry
                    .isEmpty ??
                true
            ? Icons.add
            : Icons.edit),
      ),
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
        style: TextStyle(fontSize: 12),
      ),
    );
  }
}
