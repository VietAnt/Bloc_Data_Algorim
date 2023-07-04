// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:note_pro/providers/todo_provider.dart';
import 'package:note_pro/widgets/todo_action.dart';
import 'package:provider/provider.dart';

//Todo: Home_Page
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _textFieldController = TextEditingController();
  String newTask = '';

  @override
  void initState() {
    super.initState();
    _textFieldController.addListener(() {
      newTask = _textFieldController.text;
    });
  }

  void _submit() {
    Provider.of<TodoProvider>(context, listen: false).addTask(newTask);
    Navigator.pop(context);
    _textFieldController.clear();
  }

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo Note'),
      ),
      body: TodoAction(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTextDialog();
        },
        tooltip: "Add Todo",
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _showAddTextDialog() async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add a new Task'),
          content: TextField(
            autofocus: true,
            controller: _textFieldController,
            decoration: const InputDecoration(hintText: 'Add New Task'),
            onSubmitted: (_) => _submit(),
          ),
          actions: [
            ElevatedButton(
              onPressed: _submit,
              child: const Text("Submit"),
            ),
          ],
        );
      },
    );
  }
}
