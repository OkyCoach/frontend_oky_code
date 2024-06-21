import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';
import 'package:flutter/material.dart';

final userPool = CognitoUserPool(
  dotenv.env['COGNITO_USER_POOL_ID'] ?? '',
  dotenv.env['COGNITO_CLIENT_ID'] ?? '',
);

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

class SignInResult {
  final bool verified;
  final String? message;
  final CognitoUserSession? session;

  SignInResult({required this.verified, this.message, this.session});
}

Future<SignInResult> signIn(String email, String password) async {
  try {
    final cognitoUser = CognitoUser(email, userPool);
    final authDetails = AuthenticationDetails(
      username: email,
      password: password,
    );
    var userSession = await cognitoUser.authenticateUser(authDetails);
    if (userSession != null) {
      await AuthManager().saveSession({
        'accessToken': userSession.accessToken.toString(),
        'refreshToken': userSession.refreshToken.toString(),
        'idToken': userSession.idToken.toString(),
        'userInfo': jsonEncode(userSession.idToken.payload),
      });

      const storage = FlutterSecureStorage();
      await storage.write(
          key: 'session', value: jsonEncode(userSession.toString()));
      return SignInResult(verified: true, session: userSession);
    } else {
      return SignInResult(
          verified: false, message: "An unexpected error occurred");
    }
  } on CognitoUserException catch (e) {
    return SignInResult(verified: false, message: e.message);
  } on CognitoClientException catch (e) {
    return SignInResult(verified: false, message: e.message);
  } catch (e) {
    return SignInResult(
        verified: false, message: "An unexpected error occurred");
  }
}

Future<CognitoUserPoolData?> signUp(
    String email, String password, String name, String familyName) async {
  try {
    final signUpResult = await userPool.signUp(
      email,
      password,
      userAttributes: [
        AttributeArg(name: 'name', value: name),
        AttributeArg(name: 'family_name', value: familyName),
      ],
    );
    return signUpResult;
  } catch (e) {
    return null;
  }
}

Future<bool> forgotPassword(String email) async {
  try {
    final cognitoUser = CognitoUser(email, userPool);
    var data = await cognitoUser.forgotPassword();
    return true;
  } catch (e) {
    return false;
  }
}

Future<bool> resetPassword(
    String email, String code, String newPassword) async {
  try {
    final cognitoUser = CognitoUser(email, userPool);
    var passwordConfirmed =
        await cognitoUser.confirmPassword(code, newPassword);
    return passwordConfirmed;
  } catch (e) {
    return false;
  }
}

void showError(String? message, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: const Color(0xFF7448ED),
      dismissDirection: DismissDirection.down,
      margin: const EdgeInsets.all(5),
      content: Text(
        message!,
        style: const TextStyle(
            fontFamily: "Gilroy-Semibold", fontSize: 12, color: Colors.white),
      ),
    ),
  );
}
