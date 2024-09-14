import 'package:flutter/material.dart';

class NoEvaluationPopup extends StatelessWidget {
  final dynamic product;
  final ValueChanged<bool> showNotEvaluated;
  final ValueChanged<bool> scanning;

  const NoEvaluationPopup({
    Key? key,
    required this.product,
    required this.showNotEvaluated,
    required this.scanning,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double logoWidth = 70;

    return Container(
      width: screenWidth * 0.95,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Transform.translate(
            offset: Offset(0, -logoWidth/2),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                    logoWidth),
                color: Colors.white,
                border: Border.all(
                  color: Colors.white,
                  width: 4.0, // Ancho del borde blanco
                ),
              ),
              child: Image.asset(
                "lib/assets/logos/logo_degrade.png",
                width: logoWidth,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child:  Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  product["photoUrl"] != null
                      ? Image.network(
                    product["photoUrl"],
                    height: screenWidth * 0.22,
                    width: screenWidth * 0.22,
                    errorBuilder: (BuildContext context, Object error,
                        StackTrace? stackTrace) {
                      return Image.asset(
                        'lib/assets/image_not_found.png',
                        height: screenWidth * 0.22,
                        width: screenWidth * 0.22,
                      );
                    },
                  )
                      : Image.asset(
                    'lib/assets/image_not_found.png',
                    height: screenWidth * 0.22,
                    width: screenWidth * 0.22,
                  ),
                  Expanded(
                      child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product["name"] ?? 'not_found',
                                style: TextStyle(
                                  fontFamily: "Gilroy-SemiBold",
                                  fontSize: screenWidth * 0.07,
                                  color: const Color(0xFF7448ED),
                                ),
                              ),
                              Text(
                                (product["brands"]?.isNotEmpty ?? false)
                                    ? product["brands"][0]["name"] ??
                                    'not_found'
                                    : 'not_found',
                                style: TextStyle(
                                  fontFamily: "Gilroy-Medium",
                                  fontSize: screenWidth * 0.05,
                                ),
                              ),
                            ],
                          )))
                ]),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
            child: Text(
              "No tenemos evaluación para la categoría de este producto por el momento.",
              style: TextStyle(
                fontFamily: "Gilroy-Medium",
                fontSize: screenWidth*0.05,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: InkWell(
              onTap: () {
                showNotEvaluated(false);
                scanning(true);
              },
              child: Image.asset(
                'lib/assets/botones/oky.png',
                width: screenWidth * 0.25,
              ),
            ),
          )
        ],
      )
    );
  }
}
