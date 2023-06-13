part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

//Todo: Dang_Tải
class LoadTodo extends TodoEvent {
  final List<Todo> todos;

  const LoadTodo({this.todos = const <Todo>[]});

  @override
  List<Object> get props => [todos];
}

//Todo: Thêm_todo
class AddTodo extends TodoEvent {
  final Todo todo;

  const AddTodo({required this.todo});

  @override
  List<Object> get props => [todo];
}

//Todo: Cập_nhật_todo
class UpdateTodo extends TodoEvent {
  final Todo todo;

  const UpdateTodo({required this.todo});

  @override
  List<Object> get props => [todo];
}

//Todo: Xóa_todo
class DeleteTodo extends TodoEvent {
  final Todo todo;

  const DeleteTodo({required this.todo});

  @override
  List<Object> get props => [todo];
}
