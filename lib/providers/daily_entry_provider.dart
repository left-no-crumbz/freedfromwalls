import 'package:flutter/foundation.dart';
import 'package:freedfromwalls/models/daily_entry.dart';

class DailyEntryProvider with ChangeNotifier {
  DailyEntryModel? _currentEntry;
  List<DailyEntryModel> _entries = [];

  DailyEntryModel? get currentEntry => _currentEntry;
  List<DailyEntryModel> get entries => _entries;

  void setCurrentEntry(DailyEntryModel? entry) {
    _currentEntry = entry;
    notifyListeners();
  }

  void addEntry(DailyEntryModel entry) {
    _entries.add(entry);
    notifyListeners();
  }

  void setEntries(List<DailyEntryModel> entriesArg) {
    _entries = entriesArg;
    notifyListeners();
  }

  void clearCurrentEntry() {
    _currentEntry = null;
    notifyListeners();
  }

  void updateEntry(DailyEntryModel updatedEntry) {
    final index = _entries.indexWhere((entry) => entry.id == updatedEntry.id);
    if (index != -1) {
      _entries[index] = updatedEntry;
      if (_currentEntry?.id == updatedEntry.id) {
        _currentEntry = updatedEntry;
      }
      notifyListeners();
    }
  }
}
