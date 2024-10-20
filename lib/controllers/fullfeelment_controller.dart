import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import '../models/fullfeelment.dart';

class FeelController {
  final String _baseUrl =
      "https://congenial-tribble-xjq9w997x76h6995-8000.app.github.dev/api/";
  final String _feel = "fullfeelment/";
  final Client _client = http.Client();
  static final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  Future<List<FeelModel>> fetchFeels(String id) async {
    final String? token = await secureStorage.read(key: "token");

    final Response response;

    try {
      response = await _client.get(
        Uri.parse("$_baseUrl$id/$_feel"),
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
      debugPrint("Todo Controller Controller Network error: $e");
      throw Exception(
          'ERROR: Failed to fetch bucketlists due to a network error.');
    }

    debugPrint("fetchbucketlists: ${response.statusCode}");

    if (response.statusCode == 200) {
      try {
        List<dynamic> jsonResponse = json.decode(response.body);

        List<FeelModel> feels =
            jsonResponse.map((entry) => FeelModel.fromJson(entry)).toList();

        return feels;
      } catch (e) {
        debugPrint("Todo Controller Decoding error: $e");
        throw Exception('ERROR: Failed to decode feels from JSON.');
      }
    } else {
      throw Exception(
          'ERROR: Failed to load feels. Server returned status code: ${response.statusCode}');
    }
  }

  Future<void> addFeel(FeelModel feelItem, String? userId) async {
    String? token = await secureStorage.read(key: 'token');
    debugPrint("Token: $token");

    final Response response;

    try {
      response = await _client.post(
        Uri.parse("$_baseUrl$userId/$_feel"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Token $token'
        },
        body: jsonEncode(feelItem.toJson()),
      );
    } catch (e) {
      debugPrint("Network error: $e");
      throw Exception('ERROR: Failed to add feel due to a network error.');
    }

    debugPrint("addfeellist: ${response.statusCode}");

    if (response.statusCode == 403) {
      debugPrint("ERROR: User is not authenticated");
    }

    if (response.statusCode != 200 && response.statusCode != 201) {
      debugPrint("Response body: ${response.body}");
      throw Exception('ERROR: Failed to add feel');
    }
  }

  Future<void> editFeel(
      FeelModel feelItem, String? userId, String feelId) async {
    String? token = await secureStorage.read(key: 'token');

    if (token == null) {
      debugPrint("Error: Token is null. User might not be logged in.");
      return;
    }

    // Construct the URL properly
    String url = "$_baseUrl$userId/$_feel$feelId/";
    debugPrint("Editing Feel at: $url");

    final Response response;

    try {
      // Send the PUT request to update the feel item
      response = await _client.put(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Token $token'
        },
        body: jsonEncode(
            feelItem.toJson()), // Ensure the model is serialized correctly
      );
    } catch (e) {
      debugPrint("Network error: $e");
      throw Exception('ERROR: Failed to edit feel due to a network error.');
    }

    debugPrint("editFeel: ${response.statusCode}");

    if (response.statusCode == 403) {
      debugPrint("ERROR: User is not authenticated");
    } else if (response.statusCode != 200) {
      throw Exception('ERROR: Failed to edit feel');
    }
  }

  Future<void> deleteFeel(String userId, String feelId) async {
    String? token = await secureStorage.read(
        key: 'token'); // Assuming you are using secure storage for tokens

    try {
      final Response response = await _client.delete(
        Uri.parse(
            "$_baseUrl$userId/$_feel$feelId/"), // Construct the URL with user ID and note ID
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Token $token',
        },
      );

      if (response.statusCode != 204) {
        throw Exception('Failed to delete feel item');
      }

      debugPrint("Black list item deleted successfully.");
    } catch (e) {
      debugPrint("Error deleting feel item: $e");
      throw Exception('Error deleting feel item');
    }
  }
}
