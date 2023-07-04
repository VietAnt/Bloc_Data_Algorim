import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plan_bloc/blocs/bloc/plan_bloc.dart';
import 'package:plan_bloc/models/model.dart';

class EditPlanScreen extends StatefulWidget {
  final int id;
  final String task;
  final String description;
  final String date;

  const EditPlanScreen({
    super.key,
    required this.id,
    required this.task,
    required this.description,
    required this.date,
  });

  @override
  State<EditPlanScreen> createState() => _EditPlanScreenState();
}

class _EditPlanScreenState extends State<EditPlanScreen> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _taskController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  @override
  void initState() {
    _idController.text = widget.id as String;
    _taskController.text = widget.task;
    _descriptionController.text = widget.description;
    _dateController.text = widget.date;
    super.initState();
  }

  @override
  void dispose() {
    _idController.dispose();
    _taskController.dispose();
    _descriptionController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  filled: true,
                  labelText: 'ID',
                ),
                controller: _idController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  filled: true,
                  labelText: 'Task',
                ),
                controller: _taskController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  filled: true,
                  labelText: 'Desc',
                ),
                controller: _descriptionController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: const InputDecoration(
                  filled: true,
                  labelText: 'Date',
                ),
                controller: _dateController,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                final planList = Plan(
                  id: widget.id,
                  task: _taskController.text,
                  description: _descriptionController.text,
                  date: _dateController.text,
                );
                context.read<PlanBloc>().add(UpdatePlan(planList));
                Navigator.pop(context);
              },
              child: const Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}
