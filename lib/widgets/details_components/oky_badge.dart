import 'package:flutter/material.dart';

class OkyBadge extends StatelessWidget {
  final int score;

  const OkyBadge({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      padding: const EdgeInsets.only(top: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            'lib/assets/logos/logo_degrade.png',
            height: screenHeight * 0.05,
            width: screenHeight * 0.05,
          ),
          SizedBox(width: 10,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Producto con Sello Oky",
                style: TextStyle(
                  fontFamily: "Gilroy-Regular",
                  fontSize: screenHeight * 0.015,
                ),
              ),
              Text(
                score.toString() + " pts",
                style: TextStyle(
                  fontFamily: "Gilroy-Bold",
                  fontSize: screenHeight * 0.022,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
