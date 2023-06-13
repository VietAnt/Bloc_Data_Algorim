import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_bloc/bloc/todo/todo_bloc.dart';
import 'package:note_bloc/model/todo_model.dart';
part 'todo_status_event.dart';
part 'todo_status_state.dart';

class TodoStatusBloc extends Bloc<TodoStatusEvent, TodoStatusState> {
  final TodoBloc _todoBloc;
  late StreamSubscription _todoSubcription;

  TodoStatusBloc({required TodoBloc todoBloc})
      : _todoBloc = todoBloc,
        super(TodotatusLoading()) {
    on<UpdateTodoStatus>(_onUpdateTodoStatus);

    _todoSubcription = _todoBloc.stream.listen((state) {
      if (state is TodoLoaded) {
        add(
          UpdateTodoStatus(todos: state.todos),
        );
      }
    });
  }

  void _onUpdateTodoStatus(
    UpdateTodoStatus event,
    Emitter<TodoStatusState> emit,
  ) {
    //*Đang_xử_lý
    List<Todo> pendingTodo = event.todos
        .where((todo) => todo.isCancelled == false && todo.isCompleted == false)
        .toList();

    //*Hoàn_thành
    List<Todo> completedTodo = event.todos
        .where((todo) => todo.isCompleted == true && todo.isCancelled == false)
        .toList();

    //*Bị_Hủy
    List<Todo> cancelledTodo =
        event.todos.where((todo) => todo.isCancelled == false).toList();

    emit(
      TodoStatusLoaded(
        pendingTodo: pendingTodo,
        completedTodo: completedTodo,
        cancelledTodo: cancelledTodo,
      ),
    );
  }

  @override
  Future<void> close() {
    _todoSubcription.cancel();
    return super.close();
  }
}
