import 'package:flutter/material.dart';

class NutricionistEvaluation extends StatelessWidget {
  final dynamic data; // Objeto con atributos variables

  const NutricionistEvaluation({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      color: const Color(0xFF7448ED),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Column(
          children: [
            buildRow(
              imagePath: 'lib/assets/azucar.png',
              title: 'Azucares totales',
              screenHeight: screenHeight
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Divider(color: Color(0xFF201547), thickness: 1),
            ),
            buildRow(
              imagePath: 'lib/assets/numero_ingredientes.png',
              title: 'Numero de Ingredientes',
              screenHeight: screenHeight
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Divider(color: Color(0xFF201547), thickness: 1),
            ),
            buildRow(
              imagePath: 'lib/assets/calidad_ingredientes.png',
              title: 'Calidad de Ingredientes',
              screenHeight: screenHeight
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Divider(color: Color(0xFF201547), thickness: 1),
            ),
            buildRow(
              imagePath: 'lib/assets/naturalidad.png',
              title: 'Naturalidad del producto',
              screenHeight: screenHeight
            ),
          ],
        ),
      )
    );
  }

  Widget buildRow({required String imagePath, required String title, required double screenHeight}) {
    
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipOval(
              child: ColorFiltered(
                colorFilter: const ColorFilter.mode(
                  Color(0xFFE8E4F4),
                  BlendMode.color,
                ),
                child: Image.asset(
                  imagePath,
                  height: 50,
                  width: 50,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontFamily: "Gilroy-Bold",
                        fontSize: screenHeight * 0.022,
                        color: Colors.white,
                      ),
                    ),
                    Row(
                      children: [
                        for (int i = 0; i < 4; i++)
                          Padding(
                            padding: const EdgeInsets.only(right: 3),
                            child: Image.asset(
                              'lib/assets/estrella_completa.png',
                              height: screenHeight * 0.03,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
    );
  }
}
