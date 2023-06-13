import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_bloc/model/todo_model.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoLoading()) {
    on<LoadTodo>(_onLoadTodos);
    on<AddTodo>(_onAddTodo);
    on<DeleteTodo>(_onDeleteTodo);
    on<UpdateTodo>(_onUpdateTodo);
  }

  //Todo: _onLoadTodo
  void _onLoadTodos(
    LoadTodo event,
    Emitter<TodoState> emit,
  ) {
    emit(TodoLoaded(todos: event.todos));
  }

  //Todo: _onAddTodo
  void _onAddTodo(
    AddTodo event,
    Emitter<TodoState> emit,
  ) {
    final state = this.state;
    if (state is TodoLoaded) {
      emit(TodoLoaded(todos: List.from(state.todos)..add(event.todo)));
    }
  }

  //Todo: _onDelete
  void _onDeleteTodo(
    DeleteTodo event,
    Emitter<TodoState> emit,
  ) {
    final state = this.state;
    if (state is TodoLoaded) {
      List<Todo> todos = (state.todos.where((todo) {
        return todo.id != event.todo.id;
      })).toList();

      emit(TodoLoaded(todos: todos));
    }
  }

  //Todo: _onUpdateTodo
  void _onUpdateTodo(
    UpdateTodo event,
    Emitter<TodoState> emit,
  ) {
    final state = this.state;
    if (state is TodoLoaded) {
      List<Todo> todos = (state.todos.map((todo) {
        return todo.id == event.todo.id ? event.todo : todo;
      })).toList();

      emit(TodoLoaded(todos: todos));
    }
  }
}
