//UserName
class UserName {
  final String title;
  final String first;
  final String last;

  //UserName
  UserName({
    required this.first,
    required this.last,
    required this.title,
  });

  //factory
  factory UserName.fromMap(Map<String, dynamic> json) {
    return UserName(
      first: json['first'],
      last: json['last'],
      title: json['title'],
    );
  }
}
