import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeInitial(Duration(seconds: 0)));
  Timer? timer;

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      emit(HomeTimerStarted(state.duration + const Duration(seconds: 1)));
    });
  }

  void resetTimer() {
    timer?.cancel();
    emit(const HomeInitial(Duration(seconds: 0)));
  }
}
