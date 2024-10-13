import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:freedfromwalls/models/emotion.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class EmotionController {
  final String _baseUrl = "http://192.168.100.42:8000/api/";
  final String _emotionUrl = "emotion/";

  Future<EmotionModel?> getEmotion(String title) async {
    final Response response =
        await http.get(Uri.parse("$_baseUrl$_emotionUrl$title/"));

    debugPrint("getEmotion status code: ${response.statusCode}");
    debugPrint("getEmotion body: ${response.body}");

    if (response.statusCode == 200) {
      debugPrint("INFO: getEmotion successful!");
      EmotionModel updatedEmotion =
          EmotionModel.fromJson(jsonDecode(response.body));
      return updatedEmotion;
    }

    return null;
  }
}
