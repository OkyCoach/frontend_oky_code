// auth_manager.dart
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthManager {
  static final AuthManager _instance = AuthManager._internal();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  factory AuthManager() {
    return _instance;
  }

  AuthManager._internal();

  Future<void> saveSession(Map<String, dynamic> sessionData) async {
    // Assuming sessionData contains keys like 'accessToken', 'refreshToken', etc.
    for (var entry in sessionData.entries) {
      await _storage.write(key: entry.key, value: entry.value);
    }
  }

  Future<Map<String, String>> getSession() async {
    // Add all keys that you have saved in the session
    List<String> keys = ['accessToken', 'refreshToken', 'idToken', 'userInfo'];
    Map<String, String> sessionData = {};
    for (String key in keys) {
      String? value = await _storage.read(key: key);
      if (value != null) {
        sessionData[key] = value;
      }
    }

    return sessionData;
  }



  Future<String> returnSession() async {
    String? session = await _storage.read(key: 'session');
    return session!;
  }

  Future<bool> isLoggedIn() async {
    String? accessToken = await _storage.read(key: 'accessToken');
    // Additional logic to check if the token is expired should be added here.
    return accessToken != null && accessToken.isNotEmpty;
  }

  Future<void> clearSession() async {
    await _storage.deleteAll();
  }

  // Add any other authentication-related logic here, such as refreshing tokens
}
