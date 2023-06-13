// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:todo_restfull_api/services/todo_service.dart';
import 'package:todo_restfull_api/snackbar/snackbar_helper.dart';

class AddTodoPage extends StatefulWidget {
  final Map? todo;

  const AddTodoPage({super.key, this.todo});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  //Todo: EditController
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isEdit = false;

  //Todo: initState: khoi tao du lieu
  @override
  void initState() {
    super.initState();
    final todo = widget.todo;
    if (todo != null) {
      isEdit = true;
      final title = todo['title'];
      final description = todo['description'];
      titleController.text = title;
      descriptionController.text = description;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Todo' : 'Add Todo'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(hintText: 'Title'),
          ),
          const Divider(),
          TextField(
            controller: descriptionController,
            decoration: const InputDecoration(hintText: 'Description'),
            keyboardType: TextInputType.multiline,
            maxLines: 5,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              isEdit ? updateData() : submitData();
            },
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                isEdit ? 'Update' : 'Submit',
              ),
            ),
          ),
        ],
      ),
    );
  }

  //Todo: Body
  Map get body {
    //get the data from
    final title = titleController.text;
    final description = descriptionController.text;
    return {
      "title": title,
      "description": description,
      "is_completed": false,
    };
  }

  //Todo: SubmitData
  Future<void> submitData() async {
    final isSucess = await TodoService.addTodo(body);
    //show sucess or fail message on Status
    if (isSucess) {
      titleController.text = '';
      descriptionController.text = '';
      showSucessMessage(context, message: 'Creation Sucess');
    } else {
      showErrorMessage(context, message: 'Creation Failed');
    }
  }

  //Todo: UpdateData
  Future<void> updateData() async {
    //Get the data from
    final todo = widget.todo;
    if (todo == null) {
      print('You can not call update without todo data');
      return;
    }
    final id = todo['_id'];
    //submit update data  to the server
    final isSucess = await TodoService.updateTodo(id, body);
    //show sucess or fail message based on status
    if (isSucess) {
      showSucessMessage(context, message: 'Update Sucess');
    } else {
      showErrorMessage(context, message: 'Update Failed');
    }
  }
}
