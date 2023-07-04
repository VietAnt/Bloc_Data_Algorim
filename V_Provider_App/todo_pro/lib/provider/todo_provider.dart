import 'package:flutter/cupertino.dart';
import 'package:todo_pro/model/todo.dart';
import 'package:todo_pro/services/todo_services.dart';

//Todo: TodoProvider
class TodoProvider with ChangeNotifier {
  final TodoService _service = TodoService();
  bool isLoading = false;

  List<Todo> _todos = [];
  List<Todo> get todos => _todos;

  Future<void> getAllTodos() async {
    isLoading = true;
    notifyListeners();

    final response = await _service.getAll();

    _todos = response;
    isLoading = false;
    notifyListeners();
  }
}
