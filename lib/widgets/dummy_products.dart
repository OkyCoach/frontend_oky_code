import 'package:flutter/material.dart';
import 'package:frontend_oky_code/widgets/details_components/stars_widget.dart';

class DummyProduct extends StatelessWidget {

  const DummyProduct({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: screenWidth / 3,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              child: Container(// Reemplaza con la ruta de tu imagen por defecto
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8E4F4),
                        borderRadius: BorderRadius.circular(2.0), // Ajusta el valor según sea necesario
                      ),
                    ),
            ),
            const SizedBox(height: 8),
            Container(// Reemplaza con la ruta de tu imagen por defecto
              height: screenHeight * 0.015,
              width: 50,
              decoration: BoxDecoration(
                color: const Color(0xFFE8E4F4),
                borderRadius: BorderRadius.circular(2.0), // Ajusta el valor según sea necesario
              ),
            ),
            const SizedBox(height: 3),
            Container(// Reemplaza con la ruta de tu imagen por defecto
              height: screenHeight * 0.015,
              width: 50,
              decoration: BoxDecoration(
                color: const Color(0xFFE8E4F4),
                borderRadius: BorderRadius.circular(2.0), // Ajusta el valor según sea necesario
              ),
            ),
            const SizedBox(height: 3),
            Container(// Reemplaza con la ruta de tu imagen por defecto
              height: screenHeight * 0.02,
              width: 50,
              decoration: BoxDecoration(
                color: const Color(0xFFE8E4F4),
                borderRadius: BorderRadius.circular(2.0), // Ajusta el valor según sea necesario
              ),
            ),
          ],
        ),
      ),
    );
  }
}
