import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:parsing_code/model/user.dart';
import 'package:parsing_code/model/user_dob.dart';
import 'package:parsing_code/model/user_location.dart';
import 'package:parsing_code/model/user_model.dart';

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
      final date = e['dob']['date'];
      final dob = UserDob(
        age: e['dob']['age'],
        date: DateTime.parse(date),
      );

      final coordinates = LocationCoordinate(
        latitude: e['location']['coordinates']['latitude'],
        longtitude: e['location']['coordinates']['longtitude'],
      );

      final street = LocationStreet(
        name: e['location']['street']['name'],
        number: e['location']['street']['number'],
      );

      final timezone = LocationTimezone(
        offset: e['location']['timezone']['offser'],
        description: e['location']['timezone']['description'],
      );

      final location = UserLoaction(
        city: e['location']['city'],
        country: e['location']['country'],
        //* Some post code are string
        postcode: e['location']['postcode'].toString(),
        state: e['location']['state'],
        coordinates: coordinates,
        street: street,
        timezone: timezone,
      );

      return User(
        gender: e['gender'],
        email: e['email'],
        phone: e['phone'],
        cell: e['cell'],
        nat: e['nat'],
        name: name,
        dob: dob,
        location: location,
      );
    }).toList();
    return transformed;
  }
}
