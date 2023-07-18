//Todo: Album
class Album {
  final int id;
  final String title;

  const Album({
    required this.id,
    required this.title,
  });

  //fromJson
  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'],
      title: json['title'],
    );
  }
}
