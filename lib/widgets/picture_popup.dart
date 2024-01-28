import 'package:flutter/material.dart';

class PicturePopup extends StatelessWidget {
  final String type;
  const PicturePopup({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double logoWidth = 70;
    double popupHeight = 230;

    return Stack(
      alignment: AlignmentDirectional.centerStart,
      children: [
        Dialog(
          alignment: AlignmentDirectional.topStart,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          elevation: 1,
          insetPadding: EdgeInsets.only(
              top: (screenHeight - popupHeight) / 2, left: 35, right: 35),
          child: SizedBox(
            height: popupHeight,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 15, right: 15, top: 40, bottom: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      type == "frontal" ? "Foto del producto" : "Información Nutricional",
                      style: TextStyle(
                          fontFamily: "Gilroy-SemiBold",
                          fontSize: popupHeight * 0.1,
                          color: const Color(0xFF7448ED)),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Text(
                      type == "frontal" ? "Toma una foto del frente del producto y recórtala si es necesario." : "Toma una foto del frente de la información nutricional y recórtala si es necesario.",
                      style: TextStyle(
                        fontFamily: "Gilroy-Medium",
                        fontSize: type == "frontal" ? popupHeight * 0.07 :popupHeight * 0.06,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  InkWell(
                    child: Image.asset(
                      "lib/assets/botones/oky.png",
                      width: popupHeight * 0.35,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      "Volver",
                      style: TextStyle(
                          fontFamily: "Gilroy-Medium",
                          fontSize: popupHeight * 0.07,
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
