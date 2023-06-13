part of 'todo_bloc.dart';


abstract class TodosEvent {}

class FetchTodosEvent extends TodosEvent {}

class FetchTodoEvent extends TodosEvent {}
