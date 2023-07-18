// ignore_for_file: unused_import
import 'package:http/http.dart' as http;

//Todo: AuthProvider
class AuthService {
  static const baseUrl = 'https://dummyjson.com/auth/login';
  String? authToken;

  //*Login
  Future<String?> login(String username, String password) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: {
        'email': username,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      //*Lưu trữ token khi đăng nhập
      authToken = response.body;
      return authToken;
    } else {
      throw Exception("Đăng nhập không thành công");
    }
  }

  //*Logout
  void logout() {
    authToken = null;
  }
}
