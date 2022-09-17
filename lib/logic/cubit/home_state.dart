// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_cubit.dart';

class HomeState extends Equatable {
  final Duration duration;

  const HomeState({required this.duration});

  @override
  List<Object?> get props => [duration];

  HomeState copyWith({
    Duration? duration,
  }) {
    return HomeState(
      duration: duration ?? this.duration,
    );
  }
}
