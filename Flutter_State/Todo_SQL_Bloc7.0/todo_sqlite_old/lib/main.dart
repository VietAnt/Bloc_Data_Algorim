import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_sqlite/bloc/todo/todo_bloc.dart';
import 'package:todo_sqlite/repository/todo_repository.dart';
import 'package:todo_sqlite/screen/add_todo.dart';
import 'package:todo_sqlite/screen/todo_screen.dart';
import 'package:path/path.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
// Get a location using getDatabasesPath
  var databasesPath = await getDatabasesPath();
  String path = join(databasesPath, 'todo_database.db');

  Database database = await openDatabase(path, version: 1,
      onCreate: (Database db, int verison) async {
    return db.execute(
      'CREATE TABLE todos(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, description TEXT)',
    );
  });

  final todoRepository = TodoRepository(database);
  final todoBloc = TodoBloc(todoRepository);

  runApp(MyApp(todoBloc: todoBloc));
}

class MyApp extends StatelessWidget {
  final TodoBloc todoBloc;

  MyApp({required this.todoBloc});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List',
      home: Scaffold(
        appBar: AppBar(title: Text('Todo List')),
        body: Column(
          children: [
            AddTodoFormWidget(todoBloc: todoBloc),
            Expanded(
              child: TodoListWidget(todoBloc: todoBloc),
            ),
          ],
        ),
      ),
    );
  }
}
