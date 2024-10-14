import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:freedfromwalls/models/daily_entry.dart';
import 'package:freedfromwalls/models/emotion.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class EmotionController {
  final String _baseUrl = "http://192.168.100.42:8000/api/";
  final String _emotionUrl = "emotion/";
  final String _updateEmotionUrl = "update/";

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

  Future<void> updateEmotion(DailyEntryModel dailyEntry, String id) async {
    debugPrint("$_baseUrl$_emotionUrl$_updateEmotionUrl$id/");

    final Response response;

    try {
      response = await http.put(
        Uri.parse("$_baseUrl$_emotionUrl$_updateEmotionUrl$id/"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(dailyEntry.toJson()),
      );
    } catch (e) {
      debugPrint("Network error: $e");
      throw Exception(
          'ERROR: Failed to update emotion due to a network error.');
    }

    if (response.statusCode != 200) {
      throw Exception('ERROR: Failed to update entry');
    }
  }
}
