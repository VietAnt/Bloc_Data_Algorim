part of 'plan_bloc.dart';

class PlanState extends Equatable {
  final List<Plan> planList;

  const PlanState({required this.planList});

  @override
  List<Object?> get props => [planList];

  PlanState copyWith({required List<Plan> planList}) {
    return PlanState(planList: planList);
  }
}
