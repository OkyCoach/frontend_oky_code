import 'package:flutter/material.dart';

class Recommended extends StatelessWidget {
  final dynamic data;

  const Recommended({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double containerHeight = screenHeight * 0.4;
    double containerWidth = MediaQuery.of(context).size.width;

    // Calcula el ancho para cada elemento dividiendo el ancho total entre el número total de elementos (4 en este caso).
    double itemWidth = containerWidth / 4.5;

    return Container(
      height: containerHeight,
      color: const Color(0xFFFFFFFF),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: Text(
                "Te recomendamos",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF201547),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (int i = 0; i < 4; i++)
                  SizedBox(
                    width: itemWidth,
                    child: buildProduct(),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildProduct() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center, // Centra la imagen horizontalmente
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.center, // Centra la imagen horizontalmente
          child: Image.network(
            "https://static.okto.shop/img/products/s/69/64/696474485fb0343a15488288df6a0bebff0119ec_11917.jpg",
            height: 60,
            width: 60,
          ),
        ),
        const SizedBox(height: 8), // Espacio entre la imagen y el primer texto
        const Text(
          "Galletitas de arroz Arándano",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Color(0xFF201547),
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 3,
        ),
        const Text(
          "MIZOS",
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.normal,
            color: Color(0xFF201547),
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        )
      ],
    );
  }
}
