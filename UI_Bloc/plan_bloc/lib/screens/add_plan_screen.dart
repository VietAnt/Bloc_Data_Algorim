import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plan_bloc/blocs/bloc/plan_bloc.dart';

class AddPlanScreen extends StatefulWidget {
  const AddPlanScreen({super.key});

  @override
  State<AddPlanScreen> createState() => _AddPlanScreenState();
}

class _AddPlanScreenState extends State<AddPlanScreen> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _taskController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  @override
  void dispose() {
    _idController.dispose();
    _taskController.dispose();
    _dateController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Plan'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  filled: true,
                  labelText: 'id',
                ),
                controller: _idController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: const InputDecoration(
                  filled: true,
                  labelText: 'Task',
                ),
                controller: _taskController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: const InputDecoration(
                  filled: true,
                  labelText: 'Description',
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
                context.read<PlanBloc>().add(
                      AddPlan(
                        id: int.parse(_idController.text),
                        planTask: _taskController.text,
                        planDescription: _descriptionController.text,
                        date: _dateController.text,
                      ),
                    );
              },
              child: const Text('Create'),
            ),
          ],
        ),
      ),
    );
  }
}
