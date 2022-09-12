// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  final Duration duration;
  const HomeState(this.duration);

  @override
  List<Object> get props => [duration];
}

class HomeInitial extends HomeState {
  const HomeInitial(super.duration);
}

class HomeTimerStarted extends HomeState {
  const HomeTimerStarted(super.duration);
}
