import 'package:flutter/material.dart';

class TableEvaluation extends StatelessWidget {
  final dynamic data; // Objeto con atributos variables

  const TableEvaluation({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
        color: const Color(0xFFFFFFFF),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
            children: [
              buildRow(
                imagePath: 'lib/assets/calorias.png',
                title: 'Calorías',
                screenHeight: screenHeight
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Divider(color: Color(0xFFE8E4F4), thickness: 1),
              ),
              buildRow(
                imagePath: 'lib/assets/grasas.png',
                title: 'Grasas',
                screenHeight: screenHeight
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Divider(color: Color(0xFFE8E4F4), thickness: 1),
              ),
              buildRow(
                imagePath: 'lib/assets/proteinas.png',
                title: 'Proteínas',
                screenHeight: screenHeight
              ),
            ],
          ),
        ));
  }

  Widget buildRow({required String imagePath, required String title, required double screenHeight}) {
    const double padding = 15.0;
    return Padding(
        padding: const EdgeInsets.only(left: padding),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                imagePath,
                height: 50,
                width: 50,
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
                          fontSize: screenHeight * 0.022,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF201547),
                        ),
                      ),
                      Text(
                        "Según la dosis diaria recomendada",
                        style: TextStyle(
                          fontSize: screenHeight * 0.015,
                          fontWeight: FontWeight.normal,
                          color: const Color(0xFF201547),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15, right: padding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (int i = 0; i < 12; i++)
                  Image.asset(
                    'lib/assets/puntos/punto_$i.png',
                    height: screenHeight * 0.015,
                  ),
              ],
            ),
          ),
          buildRange(['ALTO', 'MODERADO', 'ADECUADO', 'BAJO'], screenHeight),
          buildRange(['>8 gr', '4-7 gr', '1-3 gr', '<1 gr'], screenHeight)
        ]));
  }
}

Widget buildRange(List<String> rangeValues, double screenHeight) {
  return Padding(
    padding: const EdgeInsets.only(top: 5, right: 15.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (int i = 0; i < rangeValues.length; i++)
          Text(
            rangeValues[i],
            style: TextStyle(
              fontSize: screenHeight * 0.012,
              fontWeight: FontWeight.normal,
              color: const Color(0xFF201547),
            ),
          ),
      ],
    ),
  );
}
