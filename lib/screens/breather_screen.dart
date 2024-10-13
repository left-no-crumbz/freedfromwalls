import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../assets/widgets/customThemes.dart';
import '../assets/widgets/title_description.dart';
import '../controllers/daily_entry_controller.dart';
import '../models/daily_entry.dart';
import '../models/emotion.dart';
import '../models/user.dart';
import '../providers/user_provider.dart';
import '../providers/emotion_provider.dart';
import './journal_entry.dart';
import '../assets/widgets/journal_entry_container.dart';
import '../assets/widgets/scrollable_calendar.dart';
import '../assets/widgets/emotion_selector.dart';

class BreatherPage extends StatefulWidget {
  const BreatherPage({super.key});

  @override
  State<BreatherPage> createState() => _BreatherPageState();
}

class _BreatherPageState extends State<BreatherPage> {
  String _currentJournalEntry = "";
  DateTime? _creationDate;
  DateTime? _editedDate;
  EmotionModel? _emotion;
  final DailyEntryController controller = DailyEntryController();
  List<DailyEntryModel> entries = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadEntries();
  }

  Future<void> _loadEntries() async {
    setState(() {
      _isLoading = true;
    });

    entries = await controller.fetchEntries();
    DateTime now = DateTime.now();

    DailyEntryModel dailyEntry = entries.firstWhere(
      (entry) =>
          "${entry.createdAt}".substring(0, 10) ==
          "${now.year}-${now.month}-${now.day}",
      orElse: () => DailyEntryModel(
        user: Provider.of<UserProvider>(context, listen: false).user!,
        journalEntry: '',
        emotion: null,
        additionalNotes: [],
      ),
    );

    if (mounted) {
      Provider.of<EmotionProvider>(context, listen: false)
          .setEmotion(dailyEntry.emotion);

      setState(() {
        _currentJournalEntry = dailyEntry.journalEntry;
        _creationDate = dailyEntry.createdAt;
        _editedDate = dailyEntry.updatedAt;

        debugPrint(
            "breather_screen.dart: ${DateFormat("h:mma").format(_editedDate!)}");
        debugPrint(
            "breather_screen.dart: ${DateFormat("h:mma").format(_editedDate!)}");
        debugPrint(
            "breather_screen.dart: ${DateFormat("h:mma").format(_editedDate!)}");

        _emotion = Provider.of<EmotionProvider>(context, listen: false).emotion;
        _isLoading = false;
      });
    }
  }

  void _updateJournalEntry(
      String entry, DateTime creationDate, DateTime editedDate) {
    setState(() {
      _currentJournalEntry = entry;
      _creationDate = creationDate;
      _editedDate = editedDate;

      debugPrint("$_editedDate");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadEntries,
              child: ListView(
                children: [
                  const TitleDescription(
                      title: "Breather",
                      description: "Take a pause for a moment"),
                  const EmotionSelectorContainer(),
                  const SizedBox(height: 16),
                  const Title(title: "Your Journal"),
                  const SizedBox(height: 8),
                  RepaintBoundary(
                      child: ScrollableCalendar(initialDate: DateTime.now())),
                  const SizedBox(height: 16),
                  JournalEntryContainer(
                    journalEntry: _currentJournalEntry,
                    creationDate: _creationDate,
                    editedDate: _editedDate,
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
        shape: const CircleBorder(),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => JournalEntryScreen(
                getCurrentTime: () => DateTime.now(),
                onJournalEntryChanged: _updateJournalEntry,
                initialEntry: _currentJournalEntry,
                initialCreationDate: _creationDate,
                initialEditedDate: _editedDate,
              ),
            ),
          );
        },
        child: Icon(_currentJournalEntry.isEmpty ? Icons.add : Icons.edit),
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
        style:
            TextStyle(fontSize: AppThemes.getResponsiveFontSize(context, 12)),
      ),
    );
  }
}
