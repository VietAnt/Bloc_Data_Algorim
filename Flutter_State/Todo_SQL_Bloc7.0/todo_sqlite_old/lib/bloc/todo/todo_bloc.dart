import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_sqlite/model/todo_model.dart';
import 'package:todo_sqlite/repository/todo_repository.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository _todoRepository;

  TodoBloc(this._todoRepository) : super(TodoInitial());

  @override
  Stream<TodoState> mapEventToState(TodoEvent event) async* {
    if (event is LoadTodo) {
      yield TodoLoading();
      try {
        final todos = await _todoRepository.fetchTodos();
        yield TodoLoaded(todos);
      } catch (e) {
        yield TodoError('Failed to load todos');
      }
    } else if (event is AddTodo) {
      try {
        await _todoRepository.addTodo(event.todo);
        final todos = await _todoRepository.fetchTodos();
        yield TodoLoaded(todos);
      } catch (e) {
        yield TodoError('Failed to add todo');
      }
    } else if (event is UpdateTodo) {
      try {
        await _todoRepository.updateTodo(event.todo);
        final todos = await _todoRepository.fetchTodos();
        yield TodoLoaded(todos);
      } catch (e) {
        yield TodoError('Failed to update todo');
      }
    } else if (event is DeleteTodo) {
      try {
        await _todoRepository.deleteTodo(event.todoId);
        final todos = await _todoRepository.fetchTodos();
        yield TodoLoaded(todos);
      } catch (e) {
        yield TodoError('Failed to delete todo');
      }
    }
  }
}
