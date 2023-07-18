import 'dart:convert';

import 'package:update_data/model/album_model.dart';
import 'package:http/http.dart' as http;

//Todo: fetchalbum
Future<Album> fetchAlbum() async {
  final response = await http.get(
    Uri.parse('https://jsonplaceholder.typicode.com/albums/1'),
  );

  if (response.statusCode == 200) {
    return Album.fromJson(
      jsonDecode(response.body),
    );
  } else {
    throw Exception('Failed to load album');
  }
}
