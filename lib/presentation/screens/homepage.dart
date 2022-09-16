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
              const Text(
                'You have been connected to the\nInternet for the past',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  if (state is HomeTimerStarted) {
                    return Text(
                      state.duration.inSeconds.toString(),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }
                  if (state is HomeInitial) {
                    return Text(
                      state.duration.inSeconds.toString(),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }
                  return const Text('Something went wrong');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
