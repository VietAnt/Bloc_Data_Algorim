part of 'todo_bloc.dart';

abstract class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object> get props => [];
}

//Todo: TodoLoading: Đang_Tải
class TodoLoading extends TodoState {}

//Todo: TodoLoaded: Tải_thành_công
class TodoLoaded extends TodoState {
  final List<Todo> todos;

  const TodoLoaded({this.todos = const <Todo>[]});

  @override
  List<Object> get props => [todos];
}

//Todo: TodoError: Tải_lỗi
class TodoError extends TodoState {}
