import 'package:flutter/material.dart';

class ProductInfoRow extends StatelessWidget {
  final String photoUrl;
  final String description;
  final String brandName;
  final int starCount;
  final int nutritionistsCount;

  const ProductInfoRow({
    Key? key,
    required this.photoUrl,
    required this.description,
    required this.brandName,
    required this.starCount,
    required this.nutritionistsCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 10, left: 15, right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          photoUrl != "not_found"
          ? Image.network(
              photoUrl, 
              height: screenHeight * 0.1,
              width: screenHeight * 0.1,
              errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                return Image.asset(
                  'lib/assets/image_not_found.png',
                  height: screenHeight * 0.1,
                  width: screenHeight * 0.1,
                );
              },
            )
          : Image.asset(
              'lib/assets/image_not_found.png', // Reemplaza con la ruta de tu imagen por defecto
              height: screenHeight * 0.1,
              width: screenHeight * 0.1,
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
                      fontSize: screenHeight * 0.022,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  Text(
                    brandName,
                    style: TextStyle(
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
                      Row(
                        children: [
                          for (int i = 0; i < starCount; i++)
                            Padding(
                              padding: const EdgeInsets.only(right: 3),
                              child: Image.asset(
                                'lib/assets/estrella_completa.png',
                                height: screenHeight * 0.03,
                              ),
                            ),
                        ],
                      ),
                      Text(
                        "Evaluado por $nutritionistsCount nutricionistas",
                        style:  TextStyle(
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
