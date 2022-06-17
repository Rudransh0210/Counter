part of 'counter_bloc.dart';

@immutable
abstract class CounterEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class Increment extends CounterEvent {}

class Decrement extends CounterEvent {}

class GetBinaryList extends CounterEvent {}
