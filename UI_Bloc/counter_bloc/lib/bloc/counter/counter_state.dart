part of 'counter_bloc.dart';

class CounterState {}

class LoadingState extends CounterState {}

class UpdateState extends CounterState {
  final int counter;

  UpdateState(this.counter);
}
