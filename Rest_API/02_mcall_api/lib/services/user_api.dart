import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:model_call_api/model/user.dart';
import 'package:model_call_api/model/user_name.dart';

class UserApi {
  //Todo: fetcheuser
  static Future<List<User>> fetchUsers() async {
    print('fetcher called');
    const url = 'https://randomuser.me/api/?results=100';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    final results = json['results'] as List<dynamic>;
    final transformed = results.map((e) {
      final name = UserName(
        title: e['name']['title'],
        first: e['name']['first'],
        last: e['name']['last'],
      );
      return User(
        gender: e['gender'],
        email: e['email'],
        phone: e['phone'],
        cell: e['cell'],
        nat: e['nat'],
        name: name,
      );
    }).toList();
    return transformed;
  }
}
