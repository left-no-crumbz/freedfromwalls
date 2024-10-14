import 'package:flutter/cupertino.dart';
import 'package:freedfromwalls/models/daily_entry.dart';

class DailyEntryProvider with ChangeNotifier {
  DailyEntryModel? _dailyEntry;
  DailyEntryModel? get dailyEntry => _dailyEntry;

  void setEntry(DailyEntryModel? dailyEntry) {
    _dailyEntry = dailyEntry;
    notifyListeners();
  }

  void clearEntry() {
    _dailyEntry = null;
    notifyListeners();
  }
}
