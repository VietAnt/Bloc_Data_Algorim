part of 'todo_status_bloc.dart';

abstract class TodoStatusEvent extends Equatable {
  const TodoStatusEvent();

  @override
  List<Object> get props => [];
}

//Todo:UpdateTodoStatus: Cập_nhật_trạng_thái
class UpdateTodoStatus extends TodoStatusEvent {
  final List<Todo> todos;

  const UpdateTodoStatus({this.todos = const <Todo>[]});

  @override
  List<Object> get props => [todos];
}
