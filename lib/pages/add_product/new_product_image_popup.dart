import 'package:flutter/material.dart';
import 'package:frontend_oky_code/widgets/custom_button.dart';

class NewProductImagePopup extends StatelessWidget {
  final VoidCallback onOkyPressed;
  final String type;
  const NewProductImagePopup({
    Key? key,
    required this.onOkyPressed,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double popupHeight = 250;

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
              top: (screenHeight - popupHeight) / 2, left: 20, right: 20),
          elevation: 1,
          child: SizedBox(
            height: popupHeight,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10, top: 20),
                    child: Text(
                      "Foto del producto",
                      style: TextStyle(
                          fontFamily: "Gilroy-SemiBold",
                          fontSize: screenHeight * 0.03,
                          color: const Color(0xFF7448ED)),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Text(
                      type=="frontal" ? "Toma una foto del frente del producto y recórtala si es necesario." : "Toma una foto de la información nutricional y recórtala si es necesario." ,
                      style: TextStyle(
                        fontFamily: "Gilroy-Medium",
                        fontSize: screenHeight * 0.02,
                      ),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                  InkWell(
                    onTap: onOkyPressed,
                    child: Image.asset(
                      'lib/assets/botones/oky.png', // Ruta de tu imagen
                      width: screenWidth * 0.25,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Volver",
                        style: TextStyle(
                            fontFamily: "Gilroy-Medium",
                            fontSize: popupHeight * 0.055,
                            color: const Color(0xFF97999B)),
                      ),
                    )
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
