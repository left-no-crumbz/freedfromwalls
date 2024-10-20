import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:freedfromwalls/models/additional_note.dart';
import 'package:freedfromwalls/models/emotion.dart';
import 'package:freedfromwalls/providers/daily_entry_provider.dart';
import 'package:freedfromwalls/providers/emotion_provider.dart';
import 'package:freedfromwalls/screens/breather_screen.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import '../assets/widgets/customThemes.dart';
import '../assets/widgets/last_edited_info.dart';
import '../controllers/daily_entry_controller.dart';
import '../models/daily_entry.dart';
import '../models/user.dart';
import '../providers/user_provider.dart';
import 'package:provider/provider.dart';

class JournalEntryScreen extends StatefulWidget {
  final Function(String, DateTime, DateTime) onJournalEntryChanged;
  final String initialEntry;
  final DateTime Function() getCurrentTime;
  final DateTime? initialCreationDate;
  final DateTime? initialEditedDate;
  final VoidCallback onUpdate;
  final DateTime selectedDate;

  const JournalEntryScreen(
      {super.key,
      required this.onJournalEntryChanged,
      this.initialEntry = "",
      required this.getCurrentTime,
      this.initialCreationDate,
      this.initialEditedDate,
      required this.onUpdate,
      required this.selectedDate});

  @override
  State<JournalEntryScreen> createState() => _JournalEntryScreenState();
}

class _JournalEntryScreenState extends State<JournalEntryScreen> {
  late DateTime _editedDate;
  late final DateTime _creationDate;
  late final TextEditingController _journalEntryController;
  List<AdditionalNoteModel> _notes = [];
  final DailyEntryController _controller = DailyEntryController();

  @override
  void initState() {
    super.initState();
    _creationDate = widget.initialCreationDate ?? widget.getCurrentTime();
    _editedDate = widget.initialEditedDate ?? widget.getCurrentTime();
    _journalEntryController = TextEditingController(text: widget.initialEntry);
    _journalEntryController.addListener(_onJournalEntryChanged);

    setState(() {
      DailyEntryModel? dailyEntry =
          Provider.of<DailyEntryProvider>(context, listen: false).currentEntry;

      // This might break
      for (AdditionalNoteModel note in dailyEntry!.additionalNotes) {
        _notes.add(note);
      }
    });
  }

  void _onJournalEntryChanged() {
    _editedDate = widget.initialEditedDate!;

    debugPrint(
        "journal_entry.dart: ${DateFormat("h:mma").format(_editedDate)}");
    debugPrint(
        "journal_entry.dart: ${DateFormat("h:mma").format(_editedDate)}");
    debugPrint(
        "journal_entry.dart: ${DateFormat("h:mma").format(_editedDate)}");

    widget.onJournalEntryChanged(
        _journalEntryController.text, _creationDate, _editedDate);
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
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

  Future<void> _addOrUpdateEntry() async {
    UserModel? user = Provider.of<UserProvider>(context, listen: false).user;

    if (user == null) {
      debugPrint("ERROR: User is null!");
      return;
    }

    EmotionModel? emotion =
        Provider.of<EmotionProvider>(context, listen: false).emotion;

    debugPrint("journal entry emotion: $emotion");

    if (emotion == null) {
      debugPrint("Emotion is null but that's okay");
    } else {
      emotion.toJson().forEach((key, value) => debugPrint("$key: $value"));
    }

    final entry = _getEntryForDate(widget.selectedDate);
    debugPrint("INFO: Update entry successful!");
    await _controller.updateEntry(entry, entry.id.toString());
    widget.onUpdate();
  }

  @override
  void dispose() {
    _journalEntryController.removeListener(_onJournalEntryChanged);
    _journalEntryController.dispose();
    super.dispose();
  }

  Future<void> addNote(String note) async {
    DailyEntryModel? dailyEntry =
        Provider.of<DailyEntryProvider>(context, listen: false).currentEntry;

    setState(() {
      // WARNING: This might break
      _notes
          .add(AdditionalNoteModel(dailyEntryId: dailyEntry!.id!, note: note));
      dailyEntry.additionalNotes = _notes;
    });

    try {
      await _controller.updateAdditionalNotes(
          dailyEntry!, dailyEntry.id.toString());
    } catch (e) {
      debugPrint("ERROR: $e");
    }
  }

  Future<void> removeNote(int index) async {
    DailyEntryModel? dailyEntry =
        Provider.of<DailyEntryProvider>(context, listen: false).currentEntry;

    setState(() {
      _notes.removeAt(index);
      // WARNING: This might break
      dailyEntry!.additionalNotes = _notes;
    });

    try {
      await _controller.updateAdditionalNotes(
          dailyEntry!, dailyEntry.id.toString());
    } catch (e) {
      debugPrint("ERROR: $e");
    }
  }

  Future<void> editNote(int index, String newNote) async {
    DailyEntryModel? dailyEntry =
        Provider.of<DailyEntryProvider>(context, listen: false).currentEntry;

    setState(() {
      _notes[index].note = newNote;
      // WARNING: This might break
      dailyEntry!.additionalNotes = _notes;
      _editedDate = widget.initialEditedDate!;
    });

    try {
      await _controller.updateAdditionalNotes(
          dailyEntry!, dailyEntry.id.toString());
    } catch (e) {
      debugPrint("ERROR: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "FreedFrom Walls",
          style:
              TextStyle(fontSize: AppThemes.getResponsiveFontSize(context, 18)),
        ),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Journal Entry",
              style: TextStyle(
                  fontSize: AppThemes.getResponsiveFontSize(context, 20),
                  fontWeight: FontWeight.bold,
                  fontFamily: "Jua"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                LastEditedInfo(
                    creationDate: _creationDate, editedDate: _editedDate),
                Container(
                  height: 45,
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    DateFormat("yMd").format(_creationDate),
                    style: TextStyle(
                        fontSize: AppThemes.getResponsiveFontSize(context, 12),
                        color: Theme.of(context).textTheme.displaySmall?.color,
                        fontFamily: "RethinkSans",
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            const Divider(
              color: Colors.grey,
            ),
            //  A SizedBox was needed to limit the height of the TextField
            SizedBox(
              height: 250,
              child: TextField(
                controller: _journalEntryController,
                textInputAction: TextInputAction.send,
                onSubmitted: (String str) {
                  _addOrUpdateEntry();
                  FocusManager.instance.primaryFocus?.unfocus();
                  Navigator.pop(context);
                },
                maxLines: 100,
                decoration: InputDecoration(
                  hintText: "Write something here",
                  hintStyle: TextStyle(
                    fontSize: AppThemes.getResponsiveFontSize(context, 12),
                    fontStyle: FontStyle.italic,
                  ),
                  border: InputBorder.none,
                ),
                style: TextStyle(
                    fontSize: AppThemes.getResponsiveFontSize(context, 14),
                    fontStyle: FontStyle.italic,
                    fontFamily: "RethinkSans"),
              ),
            ),
            const Divider(color: Colors.grey),
            const SizedBox(height: 4),
            Container(
              height: 30,
              width: 85,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(5)),
              child: const Text(
                "NOTES",
                style: TextStyle(
                    fontFamily: "RethinkSans", fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 4),
            const Divider(color: Colors.grey),
            Expanded(
              child: ListView.builder(
                itemCount: _notes.length + 1,
                itemBuilder: (context, index) {
                  if (index == _notes.length) {
                    return NoteItem(
                      onAdd: addNote,
                    );
                  } else {
                    return NoteItem(
                      note: _notes[index].note,
                      onRemove: () => removeNote(index),
                      onEdit: (String newNote) => editNote(index, newNote),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NoteItem extends StatelessWidget {
  final String? note;
  final Function(String)? onAdd;
  final VoidCallback? onRemove;
  final Function(String)? onEdit;

  const NoteItem(
      {super.key, this.note, this.onAdd, this.onRemove, this.onEdit});

  void showNoteBottomSheet(BuildContext context, {String? initialNote}) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) => AddNoteBottomSheet(
        initialNote: initialNote,
        onTextSubmit: (String str) {
          if (initialNote == null && onAdd != null) {
            onAdd!(str);
          } else if (onEdit != null) {
            onEdit!(str);
          }
          FocusManager.instance.primaryFocus?.unfocus();
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
              child: InkWell(
                onTap: note == null
                    ? () => showNoteBottomSheet(context)
                    : onRemove,
                child: Icon(
                  note == null ? Icons.add : Icons.remove,
                  color: note == null
                      ? const Color(0xffB3B3B3)
                      : const Color(0xff000000),
                  size: 18,
                ),
              ),
            ),
            Expanded(
              child: Text(
                note ?? "Additional Notes...",
                style: TextStyle(
                    color: note == null
                        ? const Color(0xffB3B3B3)
                        : const Color(0xff000000),
                    fontSize: 12,
                    fontFamily: "RethinkSans"),
              ),
            ),
            if (note != null)
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: InkWell(
                  child: const Icon(Icons.edit, size: 18),
                  onTap: () => showNoteBottomSheet(context, initialNote: note),
                ),
              ),
          ],
        ),
        const Divider(
          color: Colors.grey,
        ),
      ],
    );
  }
}

class AddNoteBottomSheet extends StatefulWidget {
  final Function(String) onTextSubmit;
  final String? initialNote;

  const AddNoteBottomSheet(
      {super.key, required this.onTextSubmit, this.initialNote});

  @override
  State<AddNoteBottomSheet> createState() => _AddNoteBottomSheetState();
}

class _AddNoteBottomSheetState extends State<AddNoteBottomSheet> {
  late TextEditingController _noteController;

  @override
  void initState() {
    super.initState();
    _noteController = TextEditingController(text: widget.initialNote);
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: 350,
      child: TextField(
        controller: _noteController,
        textInputAction: TextInputAction.send,
        onSubmitted: (String str) {
          widget.onTextSubmit(_noteController.text);
        },
        autofocus: true,
        decoration: const InputDecoration(
          hintText: "Notes",
          hintStyle: TextStyle(
              color: Color(0xff938F8F),
              fontFamily: "RethinkSans",
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
