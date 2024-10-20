import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:convert';
import '../models/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginController {
  final Client _client = http.Client();
  final String _baseUrl =
      "https://congenial-tribble-xjq9w997x76h6995-8000.app.github.dev/api/";
  final String _loginApi = "login/";
  final String _registerApi = "register/";
  final String _getUser = "user/";
  static final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  // This is needed to update the user
  Future<UserModel> getUser(String email) async {
    late UserModel user;
    final String? token = await secureStorage.read(key: "token");
    debugPrint("$token");

    Response response = await _client.get(
      Uri.parse("$_baseUrl$_getUser"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Token $token',
      },
    );

    if (response.statusCode == 200) {
      debugPrint("User successfully updated!");
      var jsonResponse = jsonDecode(response.body);
      user = UserModel.fromJson(jsonResponse);
    } else if (response.statusCode == 403) {
      debugPrint("ERROR: Forbidden request. User is not authenticated");
    } else {
      debugPrint("ERROR: getUser function failed!");
    }
    return user;
  }

  Future<bool> login(UserModel user) async {
    try {
      final Response response = await _client.post(
        Uri.parse("$_baseUrl$_loginApi"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(user.toJson()),
      );

      // Log the response for debugging
      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        String token = responseData['token'];
        debugPrint("Token is: $token");
        await secureStorage.write(key: 'token', value: token);
        // await secureStorage.write(key: 'current_user_email', value: user.email);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint('Error: $e');
      return false;
    }
  }

  Future<bool> register(UserModel user) async {
    try {
      final Response response = await _client.post(
        Uri.parse("$_baseUrl$_registerApi"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(user.toJson()),
      );

      // Log the response for debugging
      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 201 && responseData['token'] != null) {
        String token = responseData['token'];
        debugPrint("Token is: $token");
        await secureStorage.write(key: 'token', value: token);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint('Error: $e');
      return false;
    }
  }
}
