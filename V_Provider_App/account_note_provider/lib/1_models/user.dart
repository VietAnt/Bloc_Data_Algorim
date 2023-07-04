import 'dart:convert';

//*->TodoFromJson
List<Todo> todoFromJson(String str) =>
    List<Todo>.from(json.decode(str).map((x) => Todo.fromJson(x)));

//*->TodoToJson
String todoToJson(List<Todo> data) => json.encode(
      List<dynamic>.from(data.map((x) => x.toJson())),
    );

//Todo: Todo
class Todo {
  int? id;
  String? user;
  String? value;
  String? status;
  DateTime? createdAt;
  DateTime? updateAt;

  //Contructor
  Todo({
    this.id,
    this.user,
    this.value,
    this.status,
    this.createdAt,
    this.updateAt,
  });

  //*->FromJson
  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json["id"],
      user: json["user"],
      value: json["value"],
      status: json["status"],
      createdAt: DateTime.parse(json["created_at"]),
      updateAt: DateTime.parse(json["update_at"]),
    );
  }

  //*-->ToJson
  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user,
        "value": value,
        "status": status,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updateAt!.toIso8601String(),
      };
}
