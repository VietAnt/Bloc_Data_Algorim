import 'package:flutter/material.dart';
import 'package:todo_sqlite/bloc/todo/todo_bloc.dart';
import 'package:todo_sqlite/model/todo_model.dart';

class AddTodoFormWidget extends StatefulWidget {
  final TodoBloc todoBloc;
  const AddTodoFormWidget({super.key, required this.todoBloc});

  @override
  State<AddTodoFormWidget> createState() => _AddTodoFormWidgetState();
}

class _AddTodoFormWidgetState extends State<AddTodoFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: 'Title'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter a title';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _descriptionController,
            decoration: const InputDecoration(labelText: 'Description'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter a description';
              }
              return null;
            },
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                final todo = Todo(
                  title: _titleController.text,
                  description: _descriptionController.text,
                );
                widget.todoBloc.add(AddTodo(todo));
                _titleController.clear();
                _descriptionController.clear();
              }
            },
            child: const Text('Add Todo'),
          ),
        ],
      ),
    );
  }
}
