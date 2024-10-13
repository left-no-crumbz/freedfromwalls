import 'package:flutter/cupertino.dart';
import 'package:freedfromwalls/models/emotion.dart';

class EmotionProvider with ChangeNotifier {
  EmotionModel? _emotion;
  EmotionModel? get emotion => _emotion;

  void setEmotion(EmotionModel emotion) {
    _emotion = emotion;
    notifyListeners();
  }

  void clearEmotion() {
    _emotion = null;
    notifyListeners();
  }
}
