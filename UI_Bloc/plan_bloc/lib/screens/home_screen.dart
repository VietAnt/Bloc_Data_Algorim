import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plan_bloc/blocs/bloc/plan_bloc.dart';
import 'package:plan_bloc/screens/add_plan_screen.dart';
import 'package:plan_bloc/screens/edit_plan_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<PlanBloc>().add(ShowPlan());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plan Home'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var route = MaterialPageRoute(builder: (contetx) => AddPlanScreen());
          Navigator.of(context).push(route);
        },
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<PlanBloc, PlanState>(
        builder: (context, state) {
          return ListView.builder(
            itemCount: state.planList.length,
            itemBuilder: (context, index) {
              final plan = state.planList[index];
              return Padding(
                padding: EdgeInsets.all(8),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blue,
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text('ID Plan : '),
                          Text(
                            plan.id.toString(),
                            style: const TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text('Task : '),
                          Text(
                            plan.task,
                            style: const TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text('Description: '),
                          Text(
                            plan.description,
                            style: const TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text('Date : '),
                          Text(
                            plan.date,
                            style: const TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text('Completed: '),
                          Text(
                            plan.isCompleted.toString(),
                            style: const TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              context
                                  .read<PlanBloc>()
                                  .add(DeletePlan(id: plan.id.toString()));
                            },
                            icon: const Icon(
                              Icons.delete_forever,
                              color: Colors.red,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              var route = MaterialPageRoute(
                                builder: (context) => EditPlanScreen(
                                  id: plan.id,
                                  task: plan.task,
                                  description: plan.description,
                                  date: plan.date,
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
                ),
              );
            },
          );
        },
      ),
    );
  }
}
