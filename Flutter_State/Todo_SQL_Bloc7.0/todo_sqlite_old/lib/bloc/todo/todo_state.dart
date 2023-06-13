part of 'todo_bloc.dart';

abstract class TodoState {}

class TodoInitial extends TodoState {}

//TodoLoading: Dang_Tai
class TodoLoading extends TodoState {}

//TodoLoaded: Tai_thanh_cong
class TodoLoaded extends TodoState {
  final List<Todo> todos;

  TodoLoaded(this.todos);
}

//TodoError: Tai_loi
class TodoError extends TodoState {
  final String message;

  TodoError(this.message);
}
