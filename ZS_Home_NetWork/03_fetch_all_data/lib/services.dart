import 'dart:convert';

import 'package:fetch_all_data/photo_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

//Todo: Photo
// Future<List<Photo>> fetchPhotos() async {
//   final response =
//       await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));

//   if (response.statusCode == 200) {
//     List data = jsonDecode(response.body).cast<Map<String, dynamic>>();
//     return data.map<Photo>((json) => Photo.fromJson(json)).toList();
//   } else {
//     throw Exception("Failed");
//   }
// }

Future<List<Photo>> fetchPhotos(http.Client client) async {
  final response = await client
      .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));

  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parsePhotos, response.body);
}

// A function that converts a response body into a List<Photo>.
List<Photo> parsePhotos(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Photo>((json) => Photo.fromJson(json)).toList();
}
