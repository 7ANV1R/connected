import 'package:connected/logic/cubit/home_cubit.dart';
import 'package:connected/logic/cubit/internet_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<InternetCubit, InternetState>(
      listener: (context, state) {
        if (state is InternetConnected) {
          context.read<HomeCubit>().startTimer();
        }
        if (state is InternetDisconnected) {
          context.read<HomeCubit>().resetTimer();
        }
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<InternetCubit, InternetState>(
                builder: (context, state) {
                  if (state is InternetConnected && state.connectionType == ConnectionType.wifi) {
                    return const Text('Wifi');
                  }
                  if (state is InternetConnected && state.connectionType == ConnectionType.mobileData) {
                    return const Text('Mobile Data');
                  }
                  if (state is InternetDisconnected) {
                    return const Text('DC');
                  }
                  return const CircularProgressIndicator();
                },
              ),
              const Text('You have been connected to the Internet for the past'),
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  if (state is HomeTimerStarted) {
                    return Text(state.duration.inSeconds.toString());
                  }
                  if (state is HomeInitial) {
                    return Text(state.duration.inSeconds.toString());
                  }
                  return const CircularProgressIndicator();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
