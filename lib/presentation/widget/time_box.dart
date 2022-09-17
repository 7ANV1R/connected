import 'package:flutter/material.dart';

class TimerBox extends StatelessWidget {
  const TimerBox({super.key, required this.time, required this.desc});

  final String time;
  final String desc;

  @override
  Widget build(BuildContext context) {
    final textThemeData = Theme.of(context).textTheme;
    return Column(
      children: [
        Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              time,
              style: textThemeData.bodyText1!.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            )),
        const SizedBox(
          height: 8,
        ),
        Text(
          desc,
          style: textThemeData.button,
        ),
      ],
    );
  }
}
