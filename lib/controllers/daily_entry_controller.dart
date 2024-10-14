import 'package:flutter/foundation.dart';
import 'package:freedfromwalls/models/daily_entry.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:convert';
import '../controllers/login_controller.dart';

class DailyEntryController {
  Client client = http.Client();
  final String baseUrl = "http://192.168.100.42:8000/api/";
  final String entriesUrl = "entries/";
  final String createUrl = "create/";
  final String updateUrl = "/update/";
  final String todayEntryUrl = "/today-entry/";

  final String apiUrl = "http://192.168.100.42:8000/api/entries/";
  final String addApiUrl = "http://192.168.100.42:8000/api/entries/create/";
  late List<DailyEntryModel> entries = [];

  Future<List<DailyEntryModel>> fetchEntries() async {
    debugPrint("$baseUrl$entriesUrl");

    final Response response;

    try {
      response = await client.get(
        Uri.parse("$baseUrl$entriesUrl"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
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
    try {
      final response = await http.get(
        Uri.parse("$baseUrl$id$todayEntryUrl"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      debugPrint('Response status: ${response.statusCode}');

      return response;
    } catch (e) {
      debugPrint("ERROR: $e");
      return Response("null", 500,
          reasonPhrase: "Error fetching today's entry");
    }
  }

  Future<void> addEntry(DailyEntryModel dailyEntry) async {
    String? email =
        await LoginController.secureStorage.read(key: 'current_user_email');

    if (email == null) {
      debugPrint("ERROR: No user logged in");
    }

    String? token =
        await LoginController.secureStorage.read(key: 'token_$email');

    final Response response;

    try {
      response = await client.post(
        Uri.parse("$baseUrl$entriesUrl$createUrl"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(dailyEntry.toJson()),
      );
    } catch (e) {
      debugPrint("Network error: $e");
      throw Exception('ERROR: Failed to add entries due to a network error.');
    }

    debugPrint("addEntry: ${response.statusCode}");

    if (response.statusCode != 200) {
      throw Exception('ERROR: Failed to add entry');
    }
  }

  Future<void> updateEntry(DailyEntryModel dailyEntry, String id) async {
    debugPrint("$baseUrl$entriesUrl$id$updateUrl");

    final Response response;

    try {
      response = await http.put(
        Uri.parse("$baseUrl$entriesUrl$id$updateUrl"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(dailyEntry.toJson()),
      );
    } catch (e) {
      debugPrint("Network error: $e");
      throw Exception(
          'ERROR: Failed to update entries due to a network error.');
    }

    if (response.statusCode != 200) {
      throw Exception('ERROR: Failed to update entry');
    }
  }
}
