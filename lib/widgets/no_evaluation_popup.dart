import 'package:flutter/material.dart';

class NoEvaluationPopup extends StatelessWidget {
  final dynamic product;
  const NoEvaluationPopup({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double popupHeight = 350;

    double logoWidth = 70;

    return Stack(
      alignment: AlignmentDirectional.centerStart,
      children: [
        Dialog(
          alignment: AlignmentDirectional.topStart,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          insetPadding: EdgeInsets.only(
              top: (screenHeight - popupHeight) / 2, left: 15, right: 15),
          elevation: 1,
          child: SizedBox(
            height: popupHeight,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 15, right: 15, top: 40, bottom: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        product["photoUrl"] != null
                            ? Image.network(
                                product["photoUrl"],
                                height: screenWidth * 0.22,
                                width: screenWidth * 0.22,
                                errorBuilder: (BuildContext context,
                                    Object error, StackTrace? stackTrace) {
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
                                        fontSize: screenWidth * 0.06,
                                        color: const Color(0xFF7448ED),
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
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
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                    ),
                                  ],
                                )))
                      ]),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      "No tenemos evaluación para la categoría de este producto por el momento.",
                      style: TextStyle(
                        fontFamily: "Gilroy-Medium",
                        fontSize: screenWidth * 0.045,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset(
                      'lib/assets/botones/oky.png', // Ruta de tu imagen
                      width: screenWidth * 0.25,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          left: (screenWidth - logoWidth) / 2,
          top: (screenHeight - popupHeight - logoWidth) / 2,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                  logoWidth), // Para hacer un borde circular si es necesario
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
      ],
    );
  }
}
