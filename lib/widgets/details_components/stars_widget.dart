import 'package:flutter/material.dart';

class StarsWidget extends StatelessWidget {
  final int maxScore;
  final int actualScore;

  const StarsWidget(
      {Key? key, required this.maxScore, required this.actualScore})
      : super(key: key);

  double calcularEstrellas(int maxScore, int actualScore) {
    double maxStars = 5.0;
    double actualStars = (actualScore / maxScore) * maxStars;
    actualStars = (actualStars * 2).roundToDouble() / 2;
    return actualStars;
  }

  @override
  Widget build(BuildContext context) {
    double stars = calcularEstrellas(maxScore, actualScore);
    int estrellasEnteras = stars.floor();
    double fraccionEstrella = stars - estrellasEnteras;

    double screenHeight = MediaQuery.of(context).size.height;

    return Row(
      children: List.generate(
        5,
        (index) {
          if (index < estrellasEnteras) {
            // Estrella llena
            return Padding(
              padding: const EdgeInsets.only(right: 3),
              child: Image.asset(
                'lib/assets/estrella_completa.png',
                height: screenHeight * 0.03,
              ),
            );
          } else if (index == estrellasEnteras && fraccionEstrella > 0.0) {
            // Estrella a la mitad
            return Padding(
              padding: const EdgeInsets.only(right: 3),
              child: Image.asset(
                'lib/assets/estrella_mitad.png',
                height: screenHeight * 0.03,
              ),
            );
          } else {
            // Estrella vacía
            return Padding(
              padding: const EdgeInsets.only(right: 3),
              child: Image.asset(
                'lib/assets/estrella_vacia.png',
                height: screenHeight * 0.03,
              ),
            );
          }
        },
      ),
    );
  }
}
