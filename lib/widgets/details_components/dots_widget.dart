import 'package:flutter/material.dart';

class DotsWidget extends StatelessWidget {
  final List ranges;
  final int actualScore;

  const DotsWidget({Key? key, required this.ranges, required this.actualScore})
      : super(key: key);

  int getMaxValue(List<dynamic> ranges) {
    int maxValue = 0;
    for (var range in ranges) {
      if (range["max"] == 1000) {
        maxValue = range["min"];
        break; // Termina el bucle al encontrar el rango con max 1000
      }
    }
    return maxValue;
  }

  double calculateSelectedDot(int score) {
    int maxDots = 11;
    int maxScore = getMaxValue(ranges);
    score = score.clamp(0, maxScore);
    double selectedDot = ((score / maxScore) * maxDots).roundToDouble();
    return selectedDot;
  }

  @override
  Widget build(BuildContext context) {
    double selectedDot = calculateSelectedDot(actualScore);
    double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: List.generate(
            12,
            (index) {
              if (index == selectedDot) {
                return Image.asset(
                  'lib/assets/puntos/punto_${index}_selected.png',
                  height: screenHeight * 0.035,
                );
              } else {
                return Image.asset(
                  'lib/assets/puntos/punto_$index.png',
                  height: screenHeight * 0.015,
                );
              }
            },
          ),
        ));
  }
}
