import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Ingredients extends StatelessWidget {
  final List<dynamic> ingredients;

  const Ingredients({
    Key? key,
    required this.ingredients,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ingredientes:',
            style: TextStyle(
              fontFamily: "Gilroy-SemiBold",
              fontSize: screenHeight * 0.02,
              color: Color(0xFF7448ED),
              height: 1.1,
            ),
          ),
          SizedBox(height: 5),

          // Lista de ingredientes
          ...ingredients.map((ingredient) {
            String name = "- 2 Porotos";

            return Container(
              padding: EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey.shade300,
                    width: 1.0,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      name,
                      style: TextStyle(
                        fontFamily: "Gilroy-Regular",
                        fontSize: screenHeight * 0.016,
                        color: Colors.grey[800],
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
