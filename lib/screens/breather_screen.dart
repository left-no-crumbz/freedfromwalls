import 'package:flutter/material.dart';
import '../assets/widgets/title_description.dart';
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

  void _updateJournalEntry(
      String entry, DateTime creationDate, DateTime editedDate) {
    setState(() {
      _currentJournalEntry = entry;
      _creationDate = creationDate;
      _editedDate = editedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TitleDescription(
              title: "Breather", description: "Take a pause for a moment"),
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
        style: const TextStyle(fontSize: 12),
      ),
    );
  }
}
