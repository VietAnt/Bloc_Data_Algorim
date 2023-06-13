part of 'todo_bloc.dart';

abstract class TodosState {}

class TodoInitialstate extends TodosState {
  TodoInitialstate();
}

class TodoLoadingState extends TodosState {
  TodoLoadingState();
}

class TodosLoadedState extends TodosState {
  final List<Todos> todo;
  TodosLoadedState(this.todo);
}

class TodoLoadedState extends TodosState {
  final int userId;
  final int id;
  final String title;
  final bool completed;
  TodoLoadedState(this.id, this.userId, this.title, this.completed);
}

class TodoErrorState extends TodosState {
  final String errormessage;
  TodoErrorState(this.errormessage);
}
