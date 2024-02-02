import 'package:flutter/material.dart';

class NotFoundPopup extends StatelessWidget {
  const NotFoundPopup({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double popupHeight = 310;

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
              top: (screenHeight - popupHeight) / 2, left: 30, right: 30),
          elevation: 1,
          child: SizedBox(
            height: popupHeight,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10, top: 20),
                    child: Text(
                      "No pudimos encontrar el producto :(",
                      style: TextStyle(
                          fontFamily: "Gilroy-SemiBold",
                          fontSize: popupHeight * 0.07,
                          color: const Color(0xFF7448ED)),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Text(
                      "¡Tus contribuciones son valiosas! Puedes agregar el producto y ayudar a otros a encontrarlo.",
                      style: TextStyle(
                        fontFamily: "Gilroy-Medium",
                        fontSize: popupHeight * 0.055,
                      ),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                  ),
                  InkWell(
                    child: Image.asset(
                      "lib/assets/botones/agregar.png",
                      width: popupHeight * 0.5,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      "No gracias",
                      style: TextStyle(
                          fontFamily: "Gilroy-Medium",
                          fontSize: popupHeight * 0.045,
                          color: const Color(0xFF97999B)),
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
