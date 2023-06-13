// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_bloc/bloc/blocs.dart';
import 'package:note_bloc/model/todo_model.dart';
import 'package:note_bloc/screens/screen.dart';
import 'package:note_bloc/simple_bloc_observer.dart';

void main() {
  BlocOverrides.runZoned(
    () {
      runApp(const MyApp());
    },
    blocObserver: SimpleBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TodoBloc()
            ..add(
              LoadTodo(
                todos: [
                  Todo(
                    id: '1',
                    task: 'Bloc Pattern Video 1',
                    description: 'Explain the Bloc Pattern',
                  ),
                  Todo(
                    id: '2',
                    task: 'Bloc Pattern Video 2',
                    description: 'Explain the Bloc Pettran',
                  ),
                ],
              ),
            ),
        ),
        BlocProvider(
          create: (context) => TodoStatusBloc(
            todoBloc: BlocProvider.of<TodoBloc>(context),
          )..add(UpdateTodoStatus()),
        ),
      ],
      child: MaterialApp(
        title: 'Bloc Pattern - Todo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
