import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:freedfromwalls/models/daily_entry.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:convert';
import '../controllers/login_controller.dart';

class DailyEntryController {
  final Client _client = http.Client();
  final String _baseUrl = "http://192.168.100.42:8000/api/";
  final String _entriesUrl = "entries/";
  final String _createUrl = "create/entry/";
  final String _updateUrl = "/update/";
  final String _todayEntryUrl = "/today-entry/";
  final String _updateAdditionalNotesUrl = "additional-notes/update/";
  static final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  // TODO: Add user id to filter the entries per user
  Future<List<DailyEntryModel>> fetchEntries(String userId) async {
    debugPrint("$_baseUrl$_entriesUrl$userId/");
    final String? token = await secureStorage.read(key: "token");

    final Response response;

    try {
      response = await _client.get(
        Uri.parse("$_baseUrl$_entriesUrl$userId/"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Token $token'
        },
      );

      // This should not happen normally as the user should first log in when
      // using the app. As such they are automatically authenticated once they log in
      if (response.statusCode == 403) {
        debugPrint("ERROR: User is not authenticated");
      }
    } catch (e) {
      debugPrint("Daily Entry Controller Network error: $e");
      throw Exception('ERROR: Failed to fetch entries due to a network error.');
    }

    debugPrint("fetchEntries: ${response.statusCode}");

    if (response.statusCode == 200) {
      try {
        List<dynamic> jsonResponse = json.decode(response.body);

        List<DailyEntryModel> entries = jsonResponse
            .map((entry) => DailyEntryModel.fromJson(entry))
            .toList();

        return entries;
      } catch (e) {
        debugPrint("Daily Entry Controller Decoding error: $e");
        throw Exception('ERROR: Failed to decode entries from JSON.');
      }
    } else {
      throw Exception(
          'ERROR: Failed to load entries. Server returned status code: ${response.statusCode}');
    }
  }

  Future<Response> getTodayEntry(String id) async {
    final String? token = await secureStorage.read(key: "token");

    try {
      final response = await http.get(
        Uri.parse("$_baseUrl$id/$_entriesUrl"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Token $token'
        },
      );

      debugPrint('Response status: ${response.statusCode}');
      // This should not happen normally as the user should first log in when
      // using the app. As such they are automatically authenticated once they log in
      if (response.statusCode == 403) {
        debugPrint("ERROR: User is not authenticated");
      }

      return response;
    } catch (e) {
      debugPrint("ERROR: $e");
      return Response("null", 500,
          reasonPhrase: "Error fetching today's entry");
    }
  }

  Future<void> addEntry(DailyEntryModel dailyEntry) async {
    debugPrint("$_baseUrl$_entriesUrl$_createUrl");
    String? email =
        await LoginController.secureStorage.read(key: 'current_user_email');

    if (email == null) {
      debugPrint("ERROR: No user logged in");
    }

    String? token = await LoginController.secureStorage.read(key: 'token');
    debugPrint("$token");
    final Response response;

    try {
      response = await _client.post(
        Uri.parse("$_baseUrl$_entriesUrl$_createUrl"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Token $token'
        },
        body: jsonEncode(dailyEntry.toJson()),
      );
    } catch (e) {
      debugPrint("Network error: $e");
      throw Exception('ERROR: Failed to add entries due to a network error.');
    }

    debugPrint("addEntry: ${response.statusCode}");

    // This should not happen normally as the user should first log in when
    // using the app. As such they are automatically authenticated once they log in
    if (response.statusCode == 403) {
      debugPrint("ERROR: User is not authenticated");
    }

    if (response.statusCode != 200) {
      throw Exception('ERROR: Failed to add entry');
    }
  }

  Future<void> updateEntry(DailyEntryModel dailyEntry, String id) async {
    final String? token = await secureStorage.read(key: "token");

    debugPrint("$_baseUrl$_entriesUrl$id$_updateUrl");

    final Response response;

    try {
      response = await http.put(
        Uri.parse("$_baseUrl$id/$_entriesUrl"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Token $token'
        },
        body: jsonEncode(dailyEntry.toJson()),
      );
    } catch (e) {
      debugPrint("Network error: $e");
      throw Exception(
          'ERROR: Failed to update entries due to a network error.');
    }

    // This should not happen normally as the user should first log in when
    // using the app. As such they are automatically authenticated once they log in
    if (response.statusCode == 403) {
      debugPrint("ERROR: User is not authenticated");
    }

    if (response.statusCode != 200) {
      throw Exception('ERROR: Failed to update entry');
    }
  }

  Future<void> updateAdditionalNotes(
      DailyEntryModel dailyEntry, String id) async {
    debugPrint("$_baseUrl$_updateAdditionalNotesUrl$id/");

    String? token = await LoginController.secureStorage.read(key: 'token');
    final Response response;

    try {
      response = await http.put(
        Uri.parse("$_baseUrl$_updateAdditionalNotesUrl$id/"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Token $token'
        },
        body: jsonEncode(dailyEntry.toJson()),
      );
    } catch (e) {
      debugPrint("Network error: $e");
      throw Exception(
          'ERROR: Failed to update additional notes due to a network error.');
    }

    if (response.statusCode == 200) {
      debugPrint("INFO: Successfully updated additional notes");
    }
    if (response.statusCode != 200) {
      throw Exception('ERROR: Failed to update additional notes');
    }
  }
}
