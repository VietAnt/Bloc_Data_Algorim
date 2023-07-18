//Todo: User
class User {
  int id;
  String username;
  String email;
  String firstName;
  String lastName;
  //String gender;
  //String image;
  //String token;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    //required this.gender,
    //required this.image,
    //required this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      firstName: json['firstname'],
      lastName: json['lastname'],
      //gender: json['gender'],
      //image: json['image'],
      //token: json['token'],
    );
  }

  //*ToJson
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["username"] = username;
    _data["email"] = email;
    _data["firstname"] = firstName;
    _data["lastname"] = lastName;
    //_data["gender"] = gender;
    // _data["image"] = image;
    // _data["token"] = token;
    return _data;
  }
}
