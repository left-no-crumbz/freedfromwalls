import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:freedfromwalls/models/daily_entry.dart';
import 'package:freedfromwalls/models/emotion.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class EmotionController {
  final String _baseUrl =
      "https://congenial-tribble-xjq9w997x76h6995-8000.app.github.dev/api/";
  final String _emotionUrl = "emotions/";
  static final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  Future<EmotionModel?> getEmotion(String title) async {
    final String? token = await secureStorage.read(key: "token");

    final Response response = await http.get(
      Uri.parse("$_baseUrl$title/$_emotionUrl"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Token $token'
      },
    );

    debugPrint("getEmotion status code: ${response.statusCode}");
    debugPrint("getEmotion body: ${response.body}");

    // This should not happen normally as the user should first log in when
    // using the app. As such they are automatically authenticated once they log in
    if (response.statusCode == 403) {
      debugPrint("ERROR: User is not authenticated");
    }

    if (response.statusCode == 200) {
      debugPrint("INFO: getEmotion successful!");
      EmotionModel updatedEmotion =
          EmotionModel.fromJson(jsonDecode(response.body));
      return updatedEmotion;
    }

    return null;
  }

  Future<void> updateEmotion(DailyEntryModel dailyEntry, String id) async {
    debugPrint("$_baseUrl$id/$_emotionUrl");
    final String? token = await secureStorage.read(key: "token");

    final Response response;

    try {
      response = await http.put(
        Uri.parse("$_baseUrl$id/$_emotionUrl"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Token $token'
        },
        body: jsonEncode(dailyEntry.toJson()),
      );
    } catch (e) {
      debugPrint("Network error: $e");
      throw Exception(
          'ERROR: Failed to update emotion due to a network error.');
    }
    // This should not happen normally as the user should first log in when
    // using the app. As such they are automatically authenticated once they log in
    if (response.statusCode == 403) {
      debugPrint("ERROR: User is not authenticated");
    }

    debugPrint("updateEmotion: ${response.body}");
    debugPrint("updateEmotion: ${response.statusCode}");

    if (response.statusCode != 200) {
      debugPrint("${response.statusCode}");
      throw Exception('ERROR: Failed to update entry');
    }
  }
}
