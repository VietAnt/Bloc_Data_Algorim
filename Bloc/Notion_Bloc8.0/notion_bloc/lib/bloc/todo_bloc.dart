import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notion_bloc/bloc/todo_state.dart';
import 'package:notion_bloc/repositories/todo_repo.dart';
import 'package:sqflite/sqflite.dart';
import 'package:notion_bloc/model/todo_model.dart';

class TodoBloc extends Cubit<TodoState> {
  final _todoRepo = TodoRepository();
  final Database database;

  TodoBloc({required this.database}) : super(const InitTodoState(0));

  int _counter = 1;
  List<Todo> _todos = [];
  List<Todo> get todos => _todos;

  //Todo: getTodos
  Future<void> getTodos() async {
    try {
      _todos = await _todoRepo.getTodos(database: database);
      emit(InitTodoState(_counter++));
    } catch (e) {
      log(e.toString() as num);
    }
  }

  //Todo: addTodo
  Future<void> addTodo(String text) async {
    try {
      await _todoRepo.addTodo(database: database, text: text);
      emit(InitTodoState(_counter++));
      getTodos();
    } catch (e) {
      log(e.toString() as num);
    }
  }

  //Todo: removeTodo
  Future<void> removeTodo(int id) async {
    try {
      await _todoRepo.removeTodo(database: database, id: id);
      emit(InitTodoState(_counter++));
      getTodos();
    } catch (e) {
      log(e.toString() as num);
    }
  }
}
