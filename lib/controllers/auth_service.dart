import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  static const String _keyEmail = 'rememberedEmail';
  static const String _keyPassword = 'rememberedPassword';
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  Future<void> saveCredentials(String email, String password) async {
    await _storage.write(key: _keyEmail, value: email);
    await _storage.write(key: _keyPassword, value: password);
  }

  Future<Map<String, String?>> getRememberedCredentials() async {
    return {
      'email': await _storage.read(key: _keyEmail),
      'password': await _storage.read(key: _keyPassword),
    };
  }

  Future<void> clearRememberedCredentials() async {
    await _storage.delete(key: _keyEmail);
    await _storage.delete(key: _keyPassword);
  }
}
