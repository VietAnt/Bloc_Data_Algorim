import 'package:ex_note_bloc/bloc/todo_bloc.dart';
import 'package:ex_note_bloc/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BlocProvider<TodosBloc>(
          create: ((context) => TodosBloc()),
          child: const MyFirstPage(),
        ));
  }
}
