import 'package:flutter/cupertino.dart';
import 'package:freedfromwalls/models/daily_entry.dart';

class DailyEntryProvider with ChangeNotifier {
  DailyEntryModel? _dailyEntry;
  List<DailyEntryModel> _entries = [];

  DailyEntryModel? get dailyEntry => _dailyEntry;

  List<DailyEntryModel> get entries => _entries;

  void setEntry(DailyEntryModel? dailyEntry) {
    _dailyEntry = dailyEntry;
    notifyListeners();
  }

  void setEntries(List<DailyEntryModel> entriesArg) {
    _entries = entriesArg;
    notifyListeners();
  }

  void clearEntry() {
    _dailyEntry = null;
    notifyListeners();
  }
}
