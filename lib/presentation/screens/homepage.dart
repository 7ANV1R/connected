import 'package:connected/logic/cubit/home_cubit.dart';
import 'package:connected/logic/cubit/internet_cubit.dart';
import 'package:connected/presentation/widget/time_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final textThemeData = Theme.of(context).textTheme;

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
              Text(
                'You have been connected to the\nInternet for the past',
                textAlign: TextAlign.center,
                style: textThemeData.bodyText1!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  String twoDigits(int n) => n.toString().padLeft(2, '0');
                  final minutes = twoDigits(state.duration.inMinutes.remainder(60));
                  // final minutes = state.duration.inMinutes.remainder(60);
                  final seconds = twoDigits(state.duration.inSeconds.remainder(60));

                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TimerBox(time: minutes, desc: 'MINUTES'),
                        const SizedBox(
                          width: 16,
                        ),
                        TimerBox(time: seconds, desc: 'SECONDS'),
                      ],
                    ),
                  );
                },
              ),
              //TODO : showing last recorded time
            ],
          ),
        ),
      ),
    );
  }
}
