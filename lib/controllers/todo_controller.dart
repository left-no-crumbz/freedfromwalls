import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import '../models/blacklist.dart';
import '../models/bucketlist.dart';

class TodoController {
  final String _baseUrl =
      "https://congenial-tribble-xjq9w997x76h6995-8000.app.github.dev/api/";
  final String _bucketList = "bucketlist/";
  final String _blackList = "blacklist/";
  final Client _client = http.Client();
  static final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  Future<List<BucketListModel>> fetchBucketlists(String id) async {
    final String? token = await secureStorage.read(key: "token");

    final Response response;

    try {
      response = await _client.get(
        Uri.parse("$_baseUrl$id/$_bucketList"),
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

        List<BucketListModel> bucketlists = jsonResponse
            .map((entry) => BucketListModel.fromJson(entry))
            .toList();

        return bucketlists;
      } catch (e) {
        debugPrint("Todo Controller Decoding error: $e");
        throw Exception('ERROR: Failed to decode bucketlists from JSON.');
      }
    } else {
      throw Exception(
          'ERROR: Failed to load bucketlists. Server returned status code: ${response.statusCode}');
    }
  }

  Future<List<BlackListModel>> fetchBlacklists(String id) async {
    debugPrint("$_baseUrl$id/$_blackList");
    final String? token = await secureStorage.read(key: "token");

    final Response response;

    try {
      response = await _client.get(
        Uri.parse("$_baseUrl$id/$_blackList"),
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
          'ERROR: Failed to fetch blacklists due to a network error.');
    }

    debugPrint("fetchblacklists: ${response.statusCode}");

    if (response.statusCode == 200) {
      try {
        List<dynamic> jsonResponse = json.decode(response.body);

        List<BlackListModel> blacklists = jsonResponse
            .map((entry) => BlackListModel.fromJson(entry))
            .toList();

        return blacklists;
      } catch (e) {
        debugPrint("Todo Controller Decoding error: $e");
        throw Exception('ERROR: Failed to decode blacklists from JSON.');
      }
    } else {
      throw Exception(
          'ERROR: Failed to load blacklists. Server returned status code: ${response.statusCode}');
    }
  }

  Future<void> addBucketList(BucketListModel bucketlist, String id) async {
    String? token = await secureStorage.read(key: 'token');

    final Response response;

    try {
      response = await _client.post(
        Uri.parse("$_baseUrl$id/$_bucketList"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Token $token'
        },
        body: jsonEncode(bucketlist.toJson()),
      );
    } catch (e) {
      debugPrint("Network error: $e");
      throw Exception(
          'ERROR: Failed to add bucketlist due to a network error.');
    }

    debugPrint("addBucketlist: ${response.statusCode}");

    // This should not happen normally as the user should first log in when
    // using the app. As such they are automatically authenticated once they log in
    if (response.statusCode == 403) {
      debugPrint("ERROR: User is not authenticated");
    }

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('ERROR: Failed to add bucketlist');
    }
  }

  Future<void> addBlackList(BlackListModel blacklist, String id) async {
    String? token = await secureStorage.read(key: 'token');

    final Response response;

    try {
      response = await _client.post(
        Uri.parse("$_baseUrl$id/$_blackList"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Token $token'
        },
        body: jsonEncode(blacklist.toJson()),
      );
    } catch (e) {
      debugPrint("Network error: $e");
      throw Exception('ERROR: Failed to add blacklist due to a network error.');
    }

    debugPrint("addBlacklist: ${response.statusCode}");

    // This should not happen normally as the user should first log in when
    // using the app. As such they are automatically authenticated once they log in
    if (response.statusCode == 403) {
      debugPrint("ERROR: User is not authenticated");
    }

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('ERROR: Failed to add blacklist');
    }
  }

  Future<void> editBucketList(
      BucketListModel bucketlist, String userId, String noteId) async {
    String? token = await secureStorage.read(key: 'token');

    if (token == null) {
      debugPrint("Error: Token is null. User might not be logged in.");
      return;
    }

    // Construct the URL properly
    String url = "$_baseUrl$userId/$_bucketList$noteId/";
    debugPrint("Editing BucketList at: $url");

    final Response response;

    try {
      // Send the PUT request to update the bucketlist item
      response = await _client.put(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Token $token'
        },
        body: jsonEncode(
            bucketlist.toJson()), // Ensure the model is serialized correctly
      );
    } catch (e) {
      debugPrint("Network error: $e");
      throw Exception(
          'ERROR: Failed to edit bucketlist due to a network error.');
    }

    debugPrint("editBucketlist: ${response.statusCode}");

    if (response.statusCode == 403) {
      debugPrint("ERROR: User is not authenticated");
    } else if (response.statusCode != 200) {
      throw Exception('ERROR: Failed to edit bucketlist');
    }
  }

  Future<void> editBlackList(
      BlackListModel blacklist, String userId, String noteId) async {
    String? token = await secureStorage.read(key: 'token');

    if (token == null) {
      debugPrint("Error: Token is null. User might not be logged in.");
      return;
    }

    // Construct the URL properly
    String url = "$_baseUrl$userId/$_blackList$noteId/";
    debugPrint("Editing BlacktList at: $url");

    final Response response;

    try {
      // Send the PUT request to update the blacklist item
      response = await _client.put(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Token $token'
        },
        body: jsonEncode(
            blacklist.toJson()), // Ensure the model is serialized correctly
      );
    } catch (e) {
      debugPrint("Network error: $e");
      throw Exception(
          'ERROR: Failed to edit blacklist due to a network error.');
    }

    debugPrint("editBlacklist: ${response.statusCode}");

    if (response.statusCode == 403) {
      debugPrint("ERROR: User is not authenticated");
    } else if (response.statusCode != 200) {
      throw Exception('ERROR: Failed to edit blacklist');
    }
  }

  Future<void> deleteBucketList(String userId, String noteId) async {
    String? token = await secureStorage.read(
        key: 'token'); // Assuming you are using secure storage for tokens

    print("$userId and $noteId");

    print(("$_baseUrl$userId/$_bucketList$noteId/"));

    try {
      final Response response = await _client.delete(
        Uri.parse(
            "$_baseUrl$userId/$_bucketList$noteId/"), // Construct the URL with user ID and note ID
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Token $token',
        },
      );

      if (response.statusCode != 204) {
        throw Exception('Failed to delete bucket list item');
      }

      debugPrint("Bucket list item deleted successfully.");
    } catch (e) {
      debugPrint("Error deleting bucket list item: $e");
      throw Exception('Error deleting bucket list item');
    }
  }

  Future<void> deleteBlackList(String userId, String noteId) async {
    String? token = await secureStorage.read(
        key: 'token'); // Assuming you are using secure storage for tokens

    try {
      final Response response = await _client.delete(
        Uri.parse(
            "$_baseUrl$userId/$_blackList$noteId/"), // Construct the URL with user ID and note ID
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Token $token',
        },
      );

      if (response.statusCode != 204) {
        throw Exception('Failed to delete black list item');
      }

      debugPrint("Black list item deleted successfully.");
    } catch (e) {
      debugPrint("Error deleting black list item: $e");
      throw Exception('Error deleting black list item');
    }
  }
}
