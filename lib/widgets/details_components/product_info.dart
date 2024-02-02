import 'package:flutter/material.dart';
import 'package:frontend_oky_code/widgets/details_components/stars_widget.dart';

class ProductInfoRow extends StatelessWidget {
  final String photoUrl;
  final String description;
  final String brandName;
  final dynamic evaluation;

  const ProductInfoRow({
    Key? key,
    required this.photoUrl,
    required this.description,
    required this.brandName,
    required this.evaluation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.only(top: 5.0, bottom: 10, left: 15, right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          photoUrl != "not_found"
          ? Image.network(
              photoUrl, 
              height: screenHeight * 0.15,
              width: screenHeight * 0.15,
              errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                return Image.asset(
                  'lib/assets/image_not_found.png',
                  height: screenHeight * 0.15,
                  width: screenHeight * 0.15,
                );
              },
            )
          : Image.asset(
              'lib/assets/image_not_found.png', // Reemplaza con la ruta de tu imagen por defecto
              height: screenHeight * 0.15,
              width: screenHeight * 0.15,
            ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    description,
                    style: TextStyle(
                      fontFamily: "Gilroy-Bold",
                      fontSize: screenHeight * 0.022,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  Text(
                    brandName,
                    style: TextStyle(
                      fontFamily: "Gilroy-Medium",
                      fontSize: screenHeight * 0.022,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      StarsWidget(
                        maxScore: evaluation["puntos_totales"],
                        actualScore: evaluation["puntos_obtenidos"]
                      ),
                      Text(
                        "Evaluado por 7 nutricionistas",
                        style:  TextStyle(
                          fontFamily: "Gilroy-Medium",
                          fontSize: screenHeight * 0.015,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
