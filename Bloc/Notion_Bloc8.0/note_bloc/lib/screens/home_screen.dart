import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_bloc/bloc/blocs.dart';
import 'package:note_bloc/model/todo_model.dart';
import 'package:note_bloc/screens/add_todo_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bloc Pattern: To Dox'),
        actions: [
          IconButton(
            onPressed: () {
              var route = MaterialPageRoute(
                builder: (context) => const AddTodoScreen(),
              );
              Navigator.push(context, route);
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: BlocBuilder<TodoStatusBloc, TodoStatusState>(
        builder: (context, state) {
          if (state is TodoLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is TodoStatusLoaded) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _todo(state.pendingTodo, 'Pending'),
                  _todo(state.completedTodo, 'Completed')
                ],
              ),
            );
          } else {
            return const Text('Something went wrong');
          }
        },
      ),
    );
  }

  //Todo: _todo
  Column _todo(List<Todo> todos, String status) {
    return Column(
      children: [
        SizedBox(
          height: 50,
          child: Row(
            children: [
              Text(
                '$status To Dos: ',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: todos.length,
          itemBuilder: (context, index) {
            return _todoCard(
              context,
              todos[index],
            );
          },
        ),
      ],
    );
  }

  //Todo: _todoCard
  Card _todoCard(
    BuildContext context,
    Todo todo,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '#${todo.id}: ${todo.task}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            BlocBuilder<TodoBloc, TodoState>(
              builder: (context, state) {
                return Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        context.read<TodoBloc>().add(
                              UpdateTodo(
                                todo: todo.copyWith(isCompleted: true),
                              ),
                            );
                      },
                      icon: const Icon(Icons.add_task),
                    ),
                    IconButton(
                      onPressed: () {
                        context.read<TodoBloc>().add(
                              DeleteTodo(
                                todo: todo.copyWith(isCancelled: true),
                              ),
                            );
                      },
                      icon: const Icon(Icons.cancel),
                    )
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
