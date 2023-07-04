import 'package:flutter_bloc/flutter_bloc.dart';
part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  int counter = 0;

  CounterBloc() : super(LoadingState()) {
    on<NumberIncrement>(_onIncrement);
    on<NumberDecrement>(_onDecrement);
  }

  void _onIncrement(
    NumberIncrement event,
    Emitter<CounterState> emit,
  ) async {
    counter = counter + 1;
    emit(UpdateState(counter));
  }

  void _onDecrement(
    NumberDecrement event,
    Emitter<CounterState> emit,
  ) async {
    counter = counter - 1;
    emit(UpdateState(counter));
  }
}
