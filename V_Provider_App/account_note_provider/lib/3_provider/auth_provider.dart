// ignore_for_file: depend_on_referenced_packages, constant_identifier_names
import 'dart:convert';
import 'package:account_note_provider/4_widgets/notification_text.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

//Todo: AuthProvider
enum Status {
  Uninitialized,
  Authenticated,
  Authenticating,
  Unauthenticated,
}

class AuthProvider with ChangeNotifier {
  Status _status = Status.Uninitialized;
  late String _token;
  NotificationText? _notification;

  Status get status => _status;
  String get token => _token;
  NotificationText? get notification => _notification;

  //*->API
  final String api = 'https://laravelreact.com/api/v1/auth';

  //*1.getToken
  Future<String?> getToken() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    String? token = storage.getString('token');
    return token;
  }

  //*2.StoreUserData: Lưu trữ dữ liệu người dùng
  storeUserData(apiResponse) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    await storage.setString('token', apiResponse['access_token']);
    await storage.setString('name', apiResponse['user']['name']);
  }

  //*3.InitAuthenProvider
  initAuthProvider() async {
    String? token = await getToken();
    if (token != null) {
      _token = token;
      _status = Status.Authenticated;
    } else {
      _status = Status.Unauthenticated;
    }
    notifyListeners();
  }

  //*4.Login
  Future<bool> login(String email, String password) async {
    _status = Status.Authenticating;
    _notification = null;
    notifyListeners();

    final url = "$api/login";

    Map<String, String> body = {
      'email': email,
      'password': password,
    };

    final response = await http.post(
      Uri.parse(url),
      body: body,
    );

    //*->200: Thanh_Cong
    if (response.statusCode == 200) {
      Map<String, dynamic> apiResponse = json.decode(response.body);
      _status = Status.Authenticated;
      _token = apiResponse['access_token'];
      await storeUserData(apiResponse);
      notifyListeners();
      return true;
    }

    //*->401: Email hoặc mật khẩu không hợp lệ.
    if (response.statusCode == 401) {
      _status = Status.Unauthenticated;
      _notification = NotificationText('Sever error', '');
      notifyListeners();
      return false;
    }

    _status = Status.Unauthenticated;
    _notification = NotificationText('Server error', '');
    return false;
  }

  //*5: Register: Đăng ký
  Future<Map> register(
    String name,
    String email,
    String password,
    String passwordConfirm,
  ) async {
    final url = "$api/register";

    Map<String, String> body = {
      'name': name,
      'email': email,
      'password': password,
      'password_confrimation': passwordConfirm,
    };

    Map<String, dynamic> result = {
      "success": false,
      "message": 'Unknown error',
    };

    final response = await http.post(
      Uri.parse(url),
      body: body,
    );

    if (response.statusCode == 200) {
      _notification =
          NotificationText('Registration successful, please log in.', 'info');
      notifyListeners();
      result['success'] = true;
      return result;
    }

    Map apiResponse = json.decode(response.body);

    //*->Kiem_tra: Email - Password
    if (response.statusCode == 422) {
      if (apiResponse['errors'].containsKey('email')) {
        result['message'] = apiResponse['errors']['email'][0];
        return result;
      }

      if (apiResponse['errors'].containsKey('password')) {
        result['message'] = apiResponse['errors']['password'][0];
        return result;
      }

      return result;
    }

    return result;
  }

  //*6: PasswordReset
  Future<bool> passwordReset(String email) async {
    final url = "$api/forgot-password";

    Map<String, String> body = {
      'email': email,
    };

    final response = await http.post(
      Uri.parse(url),
      body: body,
    );

    if (response.statusCode == 200) {
      _notification =
          NotificationText('Reset sent, Please check your inbox', 'Info');
      notifyListeners();
      return true;
    }
    return false;
  }

  //*7: logOut
  logOut([bool tokenExpired = false]) async {
    _status = Status.Unauthenticated;

    if (tokenExpired = true) {
      _notification =
          NotificationText('Session expired. Please log in  again', 'info');
    }
    notifyListeners();

    SharedPreferences storage = await SharedPreferences.getInstance();
    await storage.clear();
  }
}
