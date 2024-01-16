import 'package:flutter/material.dart';

class TableEvaluation extends StatelessWidget {
  final dynamic evaluation; // Objeto con atributos variables

  const TableEvaluation({
    Key? key,
    required this.evaluation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      color: const Color(0xFFFFFFFF),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Column(
          children: (evaluation["resultado"] as List).map<Widget>((category) {
            return buildRow(
              title: category[
                  'campo'], // Ajusta según la estructura real de tus datos
              screenHeight: screenHeight,
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget buildRow({required String title, required double screenHeight}) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'lib/assets/calorias.png',
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
                          fontFamily: "Gilroy-Bold",
                          fontSize: screenHeight * 0.022,
                          color: const Color(0xFF201547),
                        ),
                      ),
                      Text(
                        "Según la dosis diaria recomendada",
                        style: TextStyle(
                          fontFamily: "Gilroy-Medium",
                          fontSize: screenHeight * 0.015,
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
            padding: const EdgeInsets.only(top: 15),
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
          buildRange(
            evaluation["formato_algoritmo_categoria"][title]["rangos"], 
            screenHeight, 
            evaluation["formato_algoritmo_categoria"][title]["unidad"]
          ),
        ]
      )
    );
  }
}

Widget buildRange(List<dynamic> rangeValues, double screenHeight, String unit) {
  List<dynamic> orderRanges(List<dynamic> listaRangos) {
    listaRangos.sort((a, b) => a["min"].compareTo(b["min"]));
    return listaRangos;
  }

  String rangeToString(dynamic range) {
    if (range["min"] == 0) {
      return '<${range["max"]} $unit';
    } else if (range["max"] == 1000) {
      return '>${range["min"]} $unit';
    } else {
      return '${range["min"]}-${range["max"]} $unit';
    }
  }


  List<dynamic> orderedList = orderRanges(rangeValues);

  return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            for (int i = 0; i < orderedList.length; i++)
              Text(
                orderedList[i]["nombre"],
                style: TextStyle(
                  fontFamily: "Gilroy-Medium",
                  fontSize: screenHeight * 0.012,
                  color: const Color(0xFF201547),
                ),
              ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            for (int i = 0; i < orderedList.length; i++)
              Text(
                rangeToString(orderedList[i]),
                style: TextStyle(
                  fontFamily: "Gilroy-Medium",
                  fontSize: screenHeight * 0.012,
                  color: const Color(0xFF201547),
                ),
              ),
          ],
        ),
      ]));
}
