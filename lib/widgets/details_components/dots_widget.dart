import 'package:flutter/material.dart';

class DotsWidget extends StatelessWidget {
  final List ranges;
  final int actualScore;
  final int display;

  const DotsWidget(
      {Key? key,
      required this.ranges,
      required this.actualScore,
      required this.display})
      : super(key: key);

  List<num> getRangeValues(List<dynamic> ranges) {
    num maxValue = 0;
    num minValue = 0;
    for (var range in ranges) {
      if (range["max"] == 1000) {
        maxValue = range["min"];
         // Termina el bucle al encontrar el rango con max 1000
      }
      if (range["min"] == 0) {
        minValue = range["max"]; // Termina el bucle al encontrar el rango con max 1000
      }

    }
    return [minValue, maxValue];
  }

  double calculateSelectedDot(num score) {
    int maxDots = 11;
    List<num> limits = getRangeValues(ranges);
    score = score.toInt().clamp(limits[0], limits[1]);
    double selectedDot = (((score- limits[0]) / (limits[1]- limits[0])) * maxDots).roundToDouble();
    if (display == 1) {
      selectedDot = maxDots - selectedDot;
    }
    return selectedDot;
  }

  @override
  Widget build(BuildContext context) {
    double selectedDot = calculateSelectedDot(actualScore);
    double screenHeight = MediaQuery.of(context).size.height;
    

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: List.generate(
        12,
        (index) {
          if (index == selectedDot) {
            return Column(
              children: [
                Text(
                  actualScore.toStringAsFixed(0),
                  style: TextStyle(
                    fontFamily: "Gilroy-Bold",
                    fontSize: screenHeight * 0.012,
                    color: const Color(0xFF201547),
                  ),
                ),
                Image.asset(
                  'lib/assets/puntos/punto_${index}_selected.png',
                  height: screenHeight * 0.035,
                ),
              ],
            );
          } else {
            return Image.asset(
              'lib/assets/puntos/punto_$index.png',
              height: screenHeight * 0.015,
            );
          }
        },
      ),
    );
  }
}
