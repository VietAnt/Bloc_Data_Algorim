import 'package:ex_note_bloc/example/todo_model.dart';

class TodoList {
  List<Todo> todos;

  TodoList({this.todos = const []});

  void addTodo(Todo todo) {
    todos.add(todo);
  }

  void removeTodo(int index) {
    todos.removeAt(index);
  }

  void updateTodo(int index, Todo todo) {
    todos[index] = todo;
  }
}
