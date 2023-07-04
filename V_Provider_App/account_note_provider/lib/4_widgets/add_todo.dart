import 'package:flutter/material.dart';

//Todo: AddTodo
class AddTodo extends StatefulWidget {
  final Function addTodo;

  const AddTodo(this.addTodo, {super.key});

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Wrap(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
            child: TextField(
              keyboardType: TextInputType.multiline,
              minLines: 2,
              maxLines: null,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(hintText: 'New to do item'),
              controller: textController,
            ),
          ),
          ButtonBar(
            children: [
              TextButton(
                onPressed: () async {
                  await widget.addTodo(textController.text);
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                },
                child: const Text('Save'),
              )
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
}
