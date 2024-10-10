import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:convert';
import '../models/user.dart';

class LoginController {
  final Client _client = http.Client();
  final String _baseUrl = "http://192.168.100.42:8000/api/";
  final String _loginApi = "login/";
  final String _registerApi = "register/";

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
      debugPrint(responseData['status']);

      if (response.statusCode == 200) {
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

      if (responseData['status'] == 'success') {
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
