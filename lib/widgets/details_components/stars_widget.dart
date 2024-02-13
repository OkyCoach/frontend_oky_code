import 'package:flutter/material.dart';

class StarsWidget extends StatelessWidget {
  final int maxScore;
  final int actualScore;
  final double height;

  const StarsWidget(
      {Key? key, required this.maxScore, required this.actualScore, required this.height})
      : super(key: key);

  double calcularEstrellas(int maxScore, int actualScore) {
    double maxStars = 5.0;
    double actualStars = (actualScore / maxScore) * maxStars;
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
                'lib/assets/estrellas/estrella_8_8.png',
                height: screenHeight * height,
              ),
            );
          } else if (index == estrellasEnteras &&
              (0.0 < fraccionEstrella && fraccionEstrella <= 0.125)) {
            // Estrella a la mitad
            return Padding(
              padding: const EdgeInsets.only(right: 3),
              child: Image.asset(
                'lib/assets/estrellas/estrella_1_8.png',
                height: screenHeight * height,
              ),
            );
          } else if (index == estrellasEnteras &&
              (0.125 < fraccionEstrella && fraccionEstrella <= 0.250)) {
            // Estrella a la mitad
            return Padding(
              padding: const EdgeInsets.only(right: 3),
              child: Image.asset(
                'lib/assets/estrellas/estrella_2_8.png',
                height: screenHeight * height,
              ),
            );
          } else if (index == estrellasEnteras &&
              (0.250 < fraccionEstrella && fraccionEstrella <= 0.375)) {
            // Estrella a la mitad
            return Padding(
              padding: const EdgeInsets.only(right: 3),
              child: Image.asset(
                'lib/assets/estrellas/estrella_3_8.png',
                height: screenHeight * height,
              ),
            );
          } else if (index == estrellasEnteras &&
              (0.375 < fraccionEstrella && fraccionEstrella <= 0.500)) {
            // Estrella a la mitad
            return Padding(
              padding: const EdgeInsets.only(right: 3),
              child: Image.asset(
                'lib/assets/estrellas/estrella_4_8.png',
                height: screenHeight * height,
              ),
            );
          } else if (index == estrellasEnteras &&
              (0.500 < fraccionEstrella && fraccionEstrella <= 0.625)) {
            // Estrella a la mitad
            return Padding(
              padding: const EdgeInsets.only(right: 3),
              child: Image.asset(
                'lib/assets/estrellas/estrella_5_8.png',
                height: screenHeight * height,
              ),
            );
          } else if (index == estrellasEnteras &&
              (0.625 < fraccionEstrella && fraccionEstrella <= 0.750)) {
            // Estrella a la mitad
            return Padding(
              padding: const EdgeInsets.only(right: 3),
              child: Image.asset(
                'lib/assets/estrellas/estrella_6_8.png',
                height: screenHeight * height,
              ),
            );
          } else if (index == estrellasEnteras &&
              (0.750 < fraccionEstrella && fraccionEstrella <= 0.875)) {
            // Estrella a la mitad
            return Padding(
              padding: const EdgeInsets.only(right: 3),
              child: Image.asset(
                'lib/assets/estrellas/estrella_7_8.png',
                height: screenHeight * height,
              ),
            );
          } else if (index == estrellasEnteras &&
              (0.875 < fraccionEstrella && fraccionEstrella <= 1.0)) {
            // Estrella a la mitad
            return Padding(
              padding: const EdgeInsets.only(right: 3),
              child: Image.asset(
                'lib/assets/estrellas/estrella_8_8.png',
                height: screenHeight * height,
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.only(right: 3),
              child: Image.asset(
                'lib/assets/estrellas/estrella_0_8.png',
                height: screenHeight * height,
              ),
            );
          }
        },
      ),
    );
  }
}
