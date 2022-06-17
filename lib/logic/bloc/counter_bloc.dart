import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import '/models/binary_model.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc(counter)
      : super(CounterState(counterValue: counter, wasIncremented: false)) {
    on<CounterEvent>((event, emit) async {
      if (event is Increment) {
        emit(CounterState(
          counterValue: state.counterValue + 1,
          wasIncremented: true,
        ));
      }
      if (event is Decrement) {
        emit(CounterState(
            counterValue: state.counterValue - 1, wasIncremented: false));
      }
    });
  }
}
