import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/daily_entry_controller.dart';
import '../models/daily_entry.dart';
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
  final ValueNotifier<DateTime> _selectedDate = ValueNotifier(DateTime.now());
  late Future<void> _entriesFuture;

  @override
  void initState() {
    super.initState();
    _entriesFuture = _loadEntries();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Call _updateCurrentEntry here or in initState
    _updateCurrentEntry(_selectedDate.value);
  }

  void _updateCurrentEntry(DateTime date) {
    final entry = _getEntryForDate(date);
    Provider.of<DailyEntryProvider>(context, listen: false)
        .setCurrentEntry(entry);
    Provider.of<EmotionProvider>(context, listen: false)
        .setEmotion(entry.emotion);
  }

  Future<void> _loadEntries() async {
    try {
      final entries = await _controller.fetchEntries();
      if (mounted) {
        Provider.of<DailyEntryProvider>(context, listen: false)
            .setEntries(entries);
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

                    return EmotionSelectorContainer(emotion: entry.emotion);
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
                      creationDate: entry.createdAt,
                      editedDate: entry.updatedAt,
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
                onUpdate: () => setState(() {}),
              ),
            ),
          );
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
