import 'package:flutter/material.dart';
import 'package:login_token/services/auth_service.dart';

//Todo: AuthProvider
class AuthProvider with ChangeNotifier {
  final AuthService _authService;

  AuthProvider(this._authService);

  bool get isAuthenticated => _authService.authToken != null;

  //*Login
  Future<void> login(String username, String password) async {
    final token = await _authService.login(username, password);
    if (token != null) {}
    notifyListeners();
  }

  //*Logout
  void logout() {
    _authService.logout();
    // Thực hiện các công việc sau khi đăng xuất (nếu cần)
    notifyListeners();
  }
}
