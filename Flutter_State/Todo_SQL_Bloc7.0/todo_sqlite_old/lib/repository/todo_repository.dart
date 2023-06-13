import 'package:sqflite/sqflite.dart';
import 'package:todo_sqlite/model/todo_model.dart';

//Todo: TodoRepository: Kho_lưu_trữ_todo
class TodoRepository {
  final Database database;

  TodoRepository(this.database);

  //todo: fetchedTodo: Ket_Noi_Database
  Future<List<Todo>> fetchTodos() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('todos');
    return List.generate(maps.length, (i) {
      return Todo(
        id: maps[i]['id'],
        title: maps[i]['titel'],
        description: maps[i]['description'],
      );
    });
  }

  //todo: addTodo: them_database
  Future<void> addTodo(Todo todo) async {
    final db = database;
    await db.insert(
      'todos',
      {
        'title': todo.title,
        'description': todo.description,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  //todo: updateTodo:
  Future<void> updateTodo(Todo todo) async {
    final db = await database;
    await db.update(
      'todos',
      {
        'title': todo.title,
        'description': todo.description,
      },
      where: 'id = ?',
      whereArgs: [todo.id],
    );
  }

  //todo: deleteTodo
  Future<void> deleteTodo(int id) async {
    final db = await database;
    await db.delete(
      'todos',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
