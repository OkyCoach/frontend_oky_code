import 'package:flutter/material.dart';
import 'package:frontend_oky_code/widgets/details_components/dots_widget.dart';

final Map<String, dynamic> stringDisplay = {
  "proteinas": {"text": "Proteínas", "display": 0},
  "fibra": {"text": "Fibra", "display": 0},
  "hidratos": {"text": "Hidratos", "display": 1},
  "sodio": {"text": "Sodio", "display": 1},
  "azucares": {"text": "Azúcares", "display": 1},
  "calorias": {"text": "Calorías", "display": 1},
  "grasas": {"text": "Grasas", "display": 1},
};

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
              title: category['campo'],
              value: category["valor"]
                  .toInt(), // Ajusta según la estructura real de tus datos
              screenHeight: screenHeight,
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget buildRow(
      {required String title,
      required int value,
      required double screenHeight}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0, left: 30.0, right: 30.0),
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: Color.fromARGB(255, 207, 206, 206), width: 2.0)),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'lib/assets/$title.png',
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
                          stringDisplay[title]["text"],
                          style: TextStyle(
                            fontFamily: "Gilroy-Bold",
                            fontSize: screenHeight * 0.022,
                            color: const Color(0xFF201547),
                          ),
                        ),
                        Text(
                          "Según la porción recomendada.",
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
            DotsWidget(
                ranges: evaluation["formato_algoritmo_categoria"][title]
                    ["rangos"],
                actualScore: value,
                display: stringDisplay[title]["display"]),
            buildRange(
              title,
              evaluation["formato_algoritmo_categoria"][title]["rangos"],
              screenHeight,
              evaluation["formato_algoritmo_categoria"][title]["unidad"],
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildRange(
    String title, List<dynamic> rangeValues, double screenHeight, String unit) {
  List<dynamic> orderRanges(List<dynamic> rangeValues) {
    if (stringDisplay[title]["display"] == 1) {
      rangeValues.sort((a, b) => b["min"].compareTo(a["min"]));
    } else {
      rangeValues.sort((a, b) => a["min"].compareTo(b["min"]));
    }
    return rangeValues;
  }

  String rangeToString(dynamic range) {
    int meanValue = ((range["max"] + range["min"]) / 2).round();
    if (range["min"] == 0) {
      return '<${range["max"].toInt()} $unit';
    } else if (range["max"] == 1000) {
      return '>${range["min"].toInt()} $unit';
    } else {
      return '$meanValue $unit';
    }
  }

  List<dynamic> orderedList = orderRanges(rangeValues);

  return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 10),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            for (int i = 0; i < orderedList.length; i++)
              Text(
                orderedList[i]["nombre"],
                style: TextStyle(
                  fontFamily: "Gilroy-Bold",
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
                  fontFamily: "Gilroy-Bold",
                  fontSize: screenHeight * 0.012,
                  color: const Color(0xFF201547),
                ),
              ),
          ],
        ),
      ]));
}
