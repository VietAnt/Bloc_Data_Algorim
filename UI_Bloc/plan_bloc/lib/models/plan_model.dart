// ignore_for_file: must_be_immutable
import 'package:equatable/equatable.dart';

//Todo: Model
class Plan extends Equatable {
  final int id;
  final String task;
  final String description;
  final String date;
  bool? isCompleted;
  bool? isCancelled;

  //*Contructor
  Plan({
    required this.id,
    required this.task,
    required this.description,
    required this.date,
    this.isCompleted = false,
    this.isCancelled = false,
  });

  //*CopyWith
  Plan copyWith({
    int? id,
    String? task,
    String? description,
    String? date,
    bool? isCompleted,
    bool? isCancelled,
  }) {
    return Plan(
      id: id ?? this.id,
      task: task ?? this.task,
      description: description ?? this.description,
      date: date ?? this.date,
      isCompleted: isCompleted ?? this.isCompleted,
      isCancelled: isCancelled ?? this.isCancelled,
    );
  }

  @override
  List<Object?> get props => [
        id,
        task,
        description,
        date,
        isCompleted,
        isCancelled,
      ];

  static List<Plan> todos = [
    Plan(
        id: 1,
        task: 'Sample ToDo 1',
        description: 'This is a test To Do',
        date: '11/01/2023'),
    Plan(
        id: 2,
        task: 'Sample ToDo 2',
        description: 'This is a test To Do',
        date: '11/01/2023'),
  ];
}
