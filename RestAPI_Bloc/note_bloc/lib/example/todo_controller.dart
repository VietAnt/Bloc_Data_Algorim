import 'dart:convert';
import 'package:ex_note_bloc/example/todo_model.dart';
import 'package:http/http.dart' as http;

class TodoController {
  final String apiUrl;

  TodoController({required this.apiUrl});

  Future<List<Todo>> getTodos() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final todos = jsonDecode(response.body) as List<Todo>;
      return todos;
    } else {
      throw Exception('Failed to get todos');
    }
  }

  Future<void> createTodo(Todo todo) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      body: jsonEncode(todo),
    );
    if (response.statusCode == 201) {
      return;
    } else {
      throw Exception('Failed to create todo');
    }
  }

  Future<void> updateTodo(int id, Todo todo) async {
    final response = await http.put(
      Uri.parse(apiUrl + '/$id'),
      body: jsonEncode(todo),
    );
    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception('Failed to update todo');
    }
  }

  Future<void> deleteTodo(int id) async {
    final response = await http.delete(
      Uri.parse(apiUrl + '/$id'),
    );
    if (response.statusCode == 204) {
      return;
    } else {
      throw Exception('Failed to delete todo');
    }
  }
}
