import 'package:sqflite/sqflite.dart';
import 'package:notion_bloc/model/todo_model.dart';
//Todo: TodoRepositoey

class TodoRepository {
  //*1. getTodo
  Future<List<Todo>> getTodos({
    required Database database,
  }) async {
    final data = await database.rawQuery('SELECT * FROM todo');

    List<Todo> todos = [];
    for (var item in data) {
      todos.add(Todo(
        id: item['id'] as int,
        text: item['name'] as String,
      ));
    }
    return todos;
  }

  //*2.addTodo
  Future<dynamic> addTodo({
    required Database database,
    required String text,
  }) async {
    return await database.transaction((txn) async {
      await txn.rawInsert("INSERT INTO todo (name) VALUES ('$text')");
    });
  }

  //*3.removeTodo
  Future<dynamic> removeTodo({
    required Database database,
    required int id,
  }) async {
    return await database.transaction((txn) async {
      await txn.rawDelete('DELETE FROM todo where id = $id');
    });
  }
}
