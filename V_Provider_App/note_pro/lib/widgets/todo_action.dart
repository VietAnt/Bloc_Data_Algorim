import 'package:flutter/material.dart';
import 'package:note_pro/providers/todo_provider.dart';
import 'package:provider/provider.dart';

//Todo: TodoAction
class TodoAction extends StatelessWidget {
  const TodoAction({super.key});

  @override
  Widget build(BuildContext context) {
    final task = Provider.of<TodoProvider>(context);

    return ListView.builder(
      itemCount: task.allTasks.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Checkbox(
            value: task.allTasks[index].completed,
            onChanged: ((_) => task.toggleTask(task.allTasks[index])),
          ),
          title: Text(task.allTasks[index].todoTitle),
          trailing: IconButton(
            onPressed: () {
              task.deleteTask(task.allTasks[index]);
            },
            icon: const Icon(Icons.delete),
          ),
        );
      },
    );
  }
}
