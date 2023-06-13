// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Todos {
  int userId;
  int id;
  String title;
  bool completed;
  Todos({
    required this.userId,
    required this.id,
    required this.title,
    required this.completed,
  });

  Todos copyWith({
    int? userId,
    int? id,
    String? title,
    bool? completed,
  }) {
    return Todos(
      userId: userId ?? this.userId,
      id: id ?? this.id,
      title: title ?? this.title,
      completed: completed ?? this.completed,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'id': id,
      'title': title,
      'completed': completed,
    };
  }

  factory Todos.fromMap(Map<String, dynamic> map) {
    return Todos(
      userId: map['userId'] as int,
      id: map['id'] as int,
      title: map['title'] as String,
      completed: map['completed'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Todos.fromJson(String source) =>
      Todos.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Todos(userId: $userId, id: $id, title: $title, completed: $completed)';
  }

  @override
  bool operator ==(covariant Todos other) {
    if (identical(this, other)) return true;

    return other.userId == userId &&
        other.id == id &&
        other.title == title &&
        other.completed == completed;
  }

  @override
  int get hashCode {
    return userId.hashCode ^ id.hashCode ^ title.hashCode ^ completed.hashCode;
  }
}
