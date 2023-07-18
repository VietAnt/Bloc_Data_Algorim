import 'dart:convert';

import 'package:fetch_data/album_model.dart';
import 'package:http/http.dart' as http;

//Todo: FetchAlbum
Future<Album> fetchAlbum() async {
  final uri = Uri.parse('https://jsonplaceholder.typicode.com/albums/1');
  final resposne = await http.get(uri);

  if (resposne.statusCode == 200) {
    final data = jsonDecode(resposne.body);
    return Album.fromJson(data);
  } else {
    throw Exception("Failed to load album");
  }
}
