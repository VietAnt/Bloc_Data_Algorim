import 'package:ex_note_bloc/bloc/todo_bloc.dart';
import 'package:ex_note_bloc/model/todo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class MyFirstPage extends StatefulWidget {
  const MyFirstPage({Key? key}) : super(key: key);

  @override
  State<MyFirstPage> createState() => _MyFirstPageState();
}

class _MyFirstPageState extends State<MyFirstPage> {
  @override
  Widget build(BuildContext context) {
    TodosBloc todosBloc = Provider.of<TodosBloc>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photo Bloc'),
        centerTitle: true,
      ),
      body: BlocBuilder<TodosBloc, TodosState>(
        bloc: todosBloc,
        builder: (context, state) {
          if (state is TodoInitialstate) {
            return photoinitialUI();
          } else if (state is TodoLoadingState) {
            return photoLoadingUI();
          } else if (state is TodosLoadedState) {
            return photoLoadedUI(state.todo);
          } else if (state is TodoErrorState) {
            return photoErrorUI(state.errormessage);
          } else {
            return photoErrorUI('Photo error');
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          todosBloc.add(FetchTodoEvent());
        },
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }

  Widget photoinitialUI() {
    return const Center(
      child: Text('Click To Data'),
    );
  }

  Widget photoLoadingUI() {
    return const Center(
      child: CircularProgressIndicator(
        strokeWidth: 10,
        color: Colors.amber,
      ),
    );
  }

  Widget photoLoadedUI(List<Todos> todo) {
    return ListView.builder(
      itemBuilder: ((context, index) => ListTile(
            leading: CircleAvatar(
              child: Text(todo[index].id.toString()),
            ),
            title: Text(todo[index].title.toString()),
            subtitle: Text(todo[index].completed.toString()),
            trailing: Text(todo[index].id.toString()),
          )),
    );
  }

  Widget photoErrorUI(String message) {
    return Container(
      color: Colors.red,
      child: Center(
          child: Text(
        message,
        style: Theme.of(context).textTheme.headline3,
      )),
    );
  }
}
