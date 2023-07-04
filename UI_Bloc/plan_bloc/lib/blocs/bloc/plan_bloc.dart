// ignore_for_file: unrelated_type_equality_checks

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plan_bloc/models/model.dart';
import 'package:plan_bloc/repository/plan_repository.dart';
part 'plan_event.dart';
part 'plan_state.dart';

class PlanBloc extends Bloc<PlanEvent, PlanState> {
  PlanBloc() : super(const PlanState(planList: [])) {
    on<ShowPlan>(_showPlan);
    on<AddPlan>(_addPlan);
    on<UpdatePlan>(_updatePlan);
    on<DeletePlan>(_deletePlan);
  }

  //Todo: showPlan
  Future _showPlan(
    ShowPlan event,
    Emitter<PlanState> emit,
  ) async {
    final planList = await PlanRepository.selectAll(PlanRepository.planTable);

    final list = planList
        .map(
          (item) => Plan(
            id: item['planId'],
            task: item['planTask'],
            description: item['planDescription'],
            date: item['planDate'],
          ),
        )
        .toList();

    emit(state.copyWith(planList: list));
    print('Show Plan ${list.length}');
  }

  //Todo: addPlan
  Future<void> _addPlan(
    AddPlan event,
    Emitter<PlanState> emit,
  ) async {
    final list = Plan(
      id: event.id,
      task: event.planTask,
      description: event.planDescription,
      date: event.date,
    );

    PlanRepository.insert(PlanRepository.planTable, {
      'planId': list.id,
      'planTask': list.task,
      'planDescription': list.description,
      'planDate': list.date,
    });

    final newPlan = [...state.planList, list];

    emit(state.copyWith(planList: newPlan));
  }

  //Todo: deletePlan

  Future<void> _deletePlan(
    DeletePlan event,
    Emitter<PlanState> emit,
  ) async {
    final deletePlan =
        state.planList.where((Plan plan) => plan.id != event.id).toList();

    await PlanRepository.deleteById(PlanRepository.planTable, 'id', event.id);

    emit(state.copyWith(planList: deletePlan));
  }

  //TodoL updatePlan
  Future<void> _updatePlan(
    UpdatePlan event,
    Emitter<PlanState> emit,
  ) async {
    final list = state.planList.map((Plan plan) {
      if (plan.id == event.planList.id) {
        //*1: task
        PlanRepository.update(
          PlanRepository.planTable,
          'title',
          event.planList.task,
          event.planList.id,
        );
        //*2: description
        PlanRepository.update(
          PlanRepository.planTable,
          'description',
          event.planList.description,
          event.planList.id,
        );
        //*3: date
        PlanRepository.update(
          PlanRepository.planTable,
          'date',
          event.planList.date,
          event.planList.id,
        );

        return Plan(
          id: event.planList.id,
          task: event.planList.task,
          description: event.planList.description,
          date: event.planList.date,
        );
      }
      return plan;
    }).toList();
    emit(state.copyWith(planList: list));
  }
}
