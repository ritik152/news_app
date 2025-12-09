import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:latest_news/data/services/apis/apis.dart';


class ApiService {

  // Common headers (you can modify for token)
  Map<String, String> _headers({String? token}) {
    return {
      "Content-Type": "application/json",
      if (token != null) "Authorization": "Bearer $token",
    };
  }

  // -------------------------
  // GET
  // -------------------------
  static Future<dynamic> get(
      {
        Map<String, dynamic>? query,
        String? token,
      }) async {
    final url = Uri.parse(Apis.baseUrls).replace(
      queryParameters: query,
    );
    try {
      final response = await http.get(url,).timeout(const Duration(seconds: 20));
      return _processResponse(response);
    } catch (e) {
      throw Exception("GET Error → $e");
    }
  }


  // -------------------------
  // Response Handler
  // -------------------------
  static dynamic _processResponse(http.Response response) {
    final status = response.statusCode;

    if (status >= 200 && status < 300) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
        "Server Error ($status): ${response.body}",
      );
    }
  }
}

