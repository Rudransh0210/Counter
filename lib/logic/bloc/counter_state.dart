part of 'counter_bloc.dart';

class CounterState extends Equatable {
  int counterValue;
  bool wasIncremented;

  CounterState({
    required this.counterValue,
    required this.wasIncremented,
  });

  @override
  List<Object?> get props => [counterValue];
}
