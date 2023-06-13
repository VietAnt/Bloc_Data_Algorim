import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onote_sqlite/bloc/todo/todo_bloc.dart';
import 'package:onote_sqlite/screen/add_todo_screen.dart';
import 'package:onote_sqlite/screen/edit_todo_screen.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  void initState() {
    context.read<TodoBloc>().add(ShowDataEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          var route = MaterialPageRoute(
            builder: (context) => const AddTodoScreen(),
          );

          Navigator.of(context).push(route);
        },
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          return ListView.builder(
            itemCount: state.todoModel.length,
            itemBuilder: (context, index) {
              final helper = state.todoModel[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      helper.title,
                      style: const TextStyle(fontSize: 28),
                    ),
                    Text(
                      helper.desc,
                      style: const TextStyle(fontSize: 28),
                    ),
                    Text(
                      helper.date,
                      style: const TextStyle(fontSize: 28),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          onPressed: () {
                            context
                                .read<TodoBloc>()
                                .add(DeleteDataEvent(id: helper.id));
                          },
                          icon: const Icon(
                            Icons.delete_forever,
                            color: Colors.red,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            var route = MaterialPageRoute(
                              builder: (context) => EditTodoScreen(
                                id: helper.id,
                                title: helper.title,
                                desc: helper.desc,
                                date: helper.date,
                              ),
                            );
                            Navigator.of(context).push(route);
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
