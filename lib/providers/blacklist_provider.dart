import 'package:flutter/foundation.dart';
import 'package:freedfromwalls/models/blacklist.dart';

class BlackListProvider with ChangeNotifier {
  BlackListModel? _blacklist;
  List<BlackListModel> _blackLists = [];

  BlackListModel? get blacklist => _blacklist;

  void setBlackLists(List<BlackListModel> blackListsArg) {
    _blackLists = blackListsArg;
    notifyListeners();
  }
}
