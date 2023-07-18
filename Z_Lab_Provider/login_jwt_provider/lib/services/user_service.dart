//Todo: UserService
import 'dart:convert';

import 'package:login_jwt_provider/models/user_model.dart';
import 'package:http/http.dart' as http;

class UserService {
  Future<List<User>> getAll() async {
    const url = 'https://dummyjson.com/users';
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final json = "[${response.body}]";
      final list = jsonDecode(json) as List;
      final users = list.map((json) => User.fromJson(json)).toList();
      return users;
    }
    return [];
  }
}
