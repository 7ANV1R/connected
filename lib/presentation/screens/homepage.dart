import 'package:connected/logic/cubit/home_cubit.dart';
import 'package:connected/logic/cubit/internet_cubit.dart';
import 'package:connected/presentation/widget/time_box.dart';
import 'package:connected/service/local_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  LocalNotificationService localNotificationService = LocalNotificationService();
  @override
  void initState() {
    super.initState();
    localNotificationService.initNotification();
  }

  @override
  Widget build(BuildContext context) {
    final textThemeData = Theme.of(context).textTheme;

    return MultiBlocListener(
      listeners: [
        BlocListener<InternetCubit, InternetState>(
          listener: (context, state) {
            if (state is InternetConnected) {
              context.read<HomeCubit>().startTimer();
            }

            if (state is InternetDisconnected) {
              context.read<HomeCubit>().resetTimer();
            }
          },
        ),
        BlocListener<HomeCubit, HomeState>(
          listener: (context, state) {
            if (state.duration.inSeconds == 60) {
              localNotificationService.sendNotification(
                title: 'Touch Grass',
                body: 'You have been connected to the Internet for the past 1 minute',
              );
            }
          },
        ),
      ],
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
              // ElevatedButton(
              //   onPressed: () {
              //     localNotificationService.sendNotification(
              //       title: 'Title 1',
              //       body: 'This is body',
              //     );
              //   },
              //   child: const Text('Notification'),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
