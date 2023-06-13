import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_sqlite/bloc/todo/todo_bloc.dart';

class TodoListWidget extends StatelessWidget {
  final TodoBloc todoBloc;

  TodoListWidget({super.key, required this.todoBloc});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(
      bloc: todoBloc,
      builder: (context, state) {
        if (state is TodoLoading) {
          return const CircularProgressIndicator();
        } else if (state is TodoLoaded) {
          final todos = state.todos;
          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];
              return ListTile(
                title: Text(todo.title),
                subtitle: Text(todo.description),
                trailing: IconButton(
                  onPressed: () {
                    todoBloc.add(DeleteTodo(todo.id!));
                  },
                  icon: const Icon(Icons.delete),
                ),
              );
            },
          );
        } else if (state is TodoError) {
          return Text(state.message);
        }
        return Container();
      },
    );
  }
}
