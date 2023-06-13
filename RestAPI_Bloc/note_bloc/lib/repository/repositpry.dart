import 'package:ex_note_bloc/model/todo.dart';
import 'package:ex_note_bloc/repository/todo_repository.dart';

class Repository {
  final _todosApiServices = TodosApiServices();

  Future<List<Todos>> fetchTodosfromRepo() async {
    return _todosApiServices.fetchTodos();
  }
}
