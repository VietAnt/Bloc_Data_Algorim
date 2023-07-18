import 'dart:convert';

import 'package:update_data/model/album_model.dart';
import 'package:http/http.dart' as http;

//Todo: UpdateAlbum
Future<Album> updateAlbum(String title) async {
  final response = await http.put(
    Uri.parse('https://jsonplaceholder.typicode.com/albums/1'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'title': title,
    }),
  );

  if (response.statusCode == 200) {
    return Album.fromJson(
      jsonDecode(response.body),
    );
  } else {
    throw Exception('Failed to update album');
  }
}
