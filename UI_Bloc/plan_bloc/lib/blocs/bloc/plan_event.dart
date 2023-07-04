part of 'plan_bloc.dart';

abstract class PlanEvent extends Equatable {
  const PlanEvent();
}

//Todo: ShowPlan
class ShowPlan extends PlanEvent {
  @override
  List<Object?> get props => [];
}

//Todo: AddTodo
class AddPlan extends PlanEvent {
  final int id;
  final String planTask;
  final String planDescription;
  final String date;

  const AddPlan({
    required this.id,
    required this.planTask,
    required this.planDescription,
    required this.date,
  });

  @override
  List<Object> get props => [id, planTask, planDescription, date];

  AddPlan copyWith({
    int? id,
    String? planTask,
    String? planDescription,
    String? date,
  }) {
    return AddPlan(
      id: id ?? this.id,
      planTask: planTask ?? this.planTask,
      planDescription: planDescription ?? this.planDescription,
      date: date ?? this.date,
    );
  }
}

//Todo: UpdatePlan
class UpdatePlan extends PlanEvent {
  final Plan planList;

  const UpdatePlan(this.planList);

  @override
  List<Object> get props => [planList];
}

//Todo: DeletePlan
class DeletePlan extends PlanEvent {
  final String id;

  const DeletePlan({required this.id});

  DeletePlan copyWith({String? id}) {
    return DeletePlan(id: id ?? this.id);
  }

  @override
  List<Object> get props => [id];
}
