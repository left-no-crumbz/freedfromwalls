import 'package:flutter/foundation.dart';
import 'package:freedfromwalls/models/daily_entry.dart';
import 'package:freedfromwalls/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:convert';
import '../controllers/login_controller.dart';
import 'package:provider/provider.dart';

class DailyEntryController {
  Client client = http.Client();
  List<DailyEntryModel> entries = [];
  final String baseUrl = "http://192.168.100.42:8000/api/";
  final String entriesUrl = "entries/";
  final String createUrl = "create/";
  final String updateUrl = "/update/";
  final String todayEntryUrl = "/today-entry/";

  final String apiUrl = "http://192.168.100.42:8000/api/entries/";
  final String addApiUrl = "http://192.168.100.42:8000/api/entries/create/";

  Future<List<DailyEntryModel>> fetchEntries() async {
    final Response response = await client.get(Uri.parse("$baseUrl$entries"));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((entry) => DailyEntryModel.fromJson(entry))
          .toList();
    } else {
      throw Exception('Failed to load entries.');
    }
  }

  Future<Response> getTodayEntry(String id) async {
    debugPrint("Url: $baseUrl$id$todayEntryUrl");

    Response response = await http.get(
      Uri.parse("$baseUrl$id$todayEntryUrl"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    debugPrint('Response status: ${response.statusCode}');

    return response;
  }

  Future<void> addEntry(DailyEntryModel dailyEntry) async {
    String? email =
        await LoginController.secureStorage.read(key: 'current_user_email');

    if (email == null) {
      debugPrint("ERROR: No user logged in");
    }

    String? token =
        await LoginController.secureStorage.read(key: 'token_$email');

    final Response response = await client.post(
      Uri.parse("$baseUrl$entriesUrl$createUrl"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(dailyEntry.toJson()),
    );
    debugPrint("Status Code: ${response.statusCode}");
    if (response.statusCode != 200) {
      throw Exception('Failed to add entry');
    }
  }

  Future<void> updateEntry(DailyEntryModel dailyEntry, String id) async {
    debugPrint("$baseUrl$entriesUrl$id$updateUrl");
    final response = await http.put(
      Uri.parse("$baseUrl$entriesUrl$id$updateUrl"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(dailyEntry.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update entry');
    }
  }
}
