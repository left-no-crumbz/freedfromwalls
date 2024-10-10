import 'package:flutter/foundation.dart';
import 'package:freedfromwalls/models/daily_entry.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:convert';

class DailyEntryController {
  Client client = http.Client();
  List<DailyEntryModel> entries = [];
  final String apiUrl = "http://192.168.100.42:8000/api/entries/";
  final String addApiUrl = "http://192.168.100.42:8000/api/entries/create/";

  Future<List<DailyEntryModel>> fetchEntries() async {
    final Response response = await client.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((entry) => DailyEntryModel.fromJson(entry))
          .toList();
    } else {
      throw Exception('Failed to load entries.');
    }
  }

  Future<void> addEntry(DailyEntryModel dailyEntry) async {
    final Response response = await client.post(
      Uri.parse(addApiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(dailyEntry.toJson()),
    );
    debugPrint("${response.statusCode}");
    if (response.statusCode != 200) {
      throw Exception('Failed to add entry');
    }
  }

  Future<void> updateEntry(DailyEntryModel dailyEntry) async {
    final response = await http.put(
      Uri.parse(apiUrl),
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
