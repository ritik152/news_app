import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;
import 'package:googleapis_auth/googleapis_auth.dart' as auth;


class FirebaseMessageService {
  // Singleton pattern
  FirebaseMessageService._privateConstructor();
  static final FirebaseMessageService instance = FirebaseMessageService._privateConstructor();

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final _scopes = ['https://www.googleapis.com/auth/cloud-platform'];


  /// Get device FCM token
  Future<String?> getDeviceToken() async {
    try {
      String? token = await _messaging.getToken();
      print("FCM Token: $token");
      return token;
    } catch (e) {
      print("Error getting FCM token: $e");
      return null;
    }
  }

  Future<String> _getAccessToken() async {
    // Load your service account JSON stored in assets
    final jsonString = await rootBundle.loadString('assets/json/news-app-b9928-608ad1ee0efd.json');
    final credentials = ServiceAccountCredentials.fromJson(jsonString);

    final authClient = await clientViaServiceAccount(credentials, _scopes);
    final token = authClient.credentials.accessToken.data;

    authClient.close();

    return token;
  }

  Future<void> sendNotification({
    required String projectId,
    required String token,
    required String title,
    required String body,
  }) async
  {
    final accessToken = await _getAccessToken();

    final url = Uri.parse(
        "https://fcm.googleapis.com/v1/projects/$projectId/messages:send");

    final message = {
      "message": {
        "token": token,
        "notification": {"title": title, "body": body}
      }
    };

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken",
      },
      body: jsonEncode(message),
    );

    print("FCM Response: ${response.body}");
  }

}
