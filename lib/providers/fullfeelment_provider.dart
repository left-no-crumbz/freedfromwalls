import 'package:flutter/foundation.dart';
import 'package:freedfromwalls/models/fullfeelment.dart';

class FeelProvider with ChangeNotifier {
  FeelModel? _feel;
  List<FeelModel> _feels = [];

  FeelModel? get feel => _feel;

  void setFeels(List<FeelModel> feelsArg) {
    _feels = feelsArg;
    notifyListeners();
  }
}