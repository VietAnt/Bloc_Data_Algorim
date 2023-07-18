import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class AuthProvider with ChangeNotifier {
  String _token = '';
  bool _isAuthenticated = false;

  String get token => _token;
  bool get isAuthenticated => _isAuthenticated;

  Future<bool> login(String email, String password) async {
    const apiUrl = 'https://dummyjson.com/auth/login';
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode(
      {
        'username': email,
        'password': password,
      },
    );

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      _token = responseData['token'];
      _isAuthenticated = true;
      notifyListeners();
      return true;
    } else {
      _token = '';
      _isAuthenticated = false;
      notifyListeners();
      return false;
    }
  }

  void logout() {
    _token = '';
    _isAuthenticated = false;
    notifyListeners();
  }
}
