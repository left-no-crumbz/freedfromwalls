import 'package:flutter/foundation.dart';
import 'package:freedfromwalls/models/bucketlist.dart';

class BucketListProvider with ChangeNotifier {
  BucketListModel? _bucketlist;
  List<BucketListModel> _bucketLists = [];

  BucketListModel? get bucketlist => _bucketlist;

  void setBucketLists(List<BucketListModel> bucketListsArg) {
    _bucketLists = bucketListsArg;
    notifyListeners();
  }
}
