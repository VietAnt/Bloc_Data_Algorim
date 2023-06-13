part of 'todo_status_bloc.dart';

abstract class TodoStatusState extends Equatable {
  const TodoStatusState();

  @override
  List<Object> get props => [];
}

//Todo: TodoStatusLoading:
class TodotatusLoading extends TodoStatusState {}

//Todo: TodoStatusLoaded: Trạng_thái_tải_thành_công
class TodoStatusLoaded extends TodoStatusState {
  final List<Todo> pendingTodo;
  final List<Todo> completedTodo;
  final List<Todo> cancelledTodo;

  const TodoStatusLoaded({
    this.pendingTodo = const <Todo>[],
    this.completedTodo = const <Todo>[],
    this.cancelledTodo = const <Todo>[],
  });

  @override
  List<Object> get props => [
        pendingTodo,
        completedTodo,
        cancelledTodo,
      ];
}
