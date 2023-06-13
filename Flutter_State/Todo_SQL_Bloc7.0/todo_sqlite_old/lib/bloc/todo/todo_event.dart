part of 'todo_bloc.dart';

abstract class TodoEvent {}

//Todo: LoadTodo
class LoadTodo extends TodoEvent {}

//Todo: AddTodo
class AddTodo extends TodoEvent {
  final Todo todo;

  AddTodo(this.todo);
}

//Todo: UpdateTodo
class UpdateTodo extends TodoEvent {
  final Todo todo;

  UpdateTodo(this.todo);
}

//Todo: DeleteTodo
class DeleteTodo extends TodoEvent {
  final int todoId;

  DeleteTodo(this.todoId);
}
