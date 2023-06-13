import 'package:ex_note_bloc/model/todo.dart';
import 'package:ex_note_bloc/repository/repositpry.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  final Repository repository = Repository();
  TodosBloc() : super(TodoInitialstate()) {
    on<FetchTodoEvent>((event, emit) async {
      emit.call(TodoLoadingState());
      try {
        List<Todos> todo = await repository.fetchTodosfromRepo();
        emit(TodosLoadedState(todo));
      } catch (e) {
        emit(TodoErrorState(e.toString()));
      }
    });
  }
}
