import 'package:flutter/material.dart';

class NutritionalValues extends StatelessWidget {
  final Map<String, dynamic> values;


  const NutritionalValues({
    Key? key,
    required this.values,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Expanded(
              child: NutritionalItem(value: "${values["protein"] ?? "-"} gr", label: "Proteínas", image: "proteinas",)
            ),
            SizedBox(width: 5,),
            Expanded(
              child: Expanded(
                  child: NutritionalItem(value: "${values["calories"] ?? "-"} kcal", label: "Calorías", image: "calorias",)
              ),
            ),
          ],
        ),
        SizedBox(height: 5,),
        Row(
          children: [
            Expanded(
              child: Expanded(
                  child: NutritionalItem(value: "${values["fat"] ?? "-"} gr", label: "Grasas", image: "grasas_totales",)
              ),
            ),
            SizedBox(width: 5,),
            Expanded(
              child: Expanded(
                  child: NutritionalItem(value: "${values["carbohydrates"] ?? "-"} gr", label: "Carbohidratos", image: "hidratos",)
              ),
            ),
          ],
        ),
        Text(
            "*Aportes por porción.",
          style: TextStyle(
            fontFamily: "Gilroy-Regular",
            fontSize: screenHeight * 0.015,
            color: Colors.grey[800],
            height: 1.8,
          ),

        )
      ],
    );
  }
}

class NutritionalItem extends StatelessWidget {
  final String value;
  final String label;
  final String image;

  const NutritionalItem({
    Key? key,
    required this.value,
    required this.label,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Color(0xFF7448ED),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Image.asset(
            'lib/assets/$image.png',
            height: 40,
            width: 40,
          ),
          SizedBox(width: 8,),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(
                value,
                style: TextStyle(
                  color: Color(0xFF7448ED),
                    fontSize: screenHeight * 0.019,
                  fontFamily: "Gilroy-Medium",
                  fontWeight: FontWeight.bold,
                  height: 1.1
                ),
              ),
              Text(
                label,
                style: TextStyle(
                  color: Colors.grey.shade800,
                  fontFamily: "Gilroy-Regular",
                  fontSize: screenHeight * 0.016,
                ),
              ),
            ],
          )
        ]
      ),
    );
  }
}
