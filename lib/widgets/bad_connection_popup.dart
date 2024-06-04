import 'package:flutter/material.dart';

class BadConnetionPopup extends StatelessWidget {
  final bool scanning;
  final ValueChanged<bool> controlScan;

  const BadConnetionPopup({
    Key? key,
    required this.scanning,
    required this.controlScan,
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
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "Mala conexión a internet :(",
                      style: TextStyle(
                          fontFamily: "Gilroy-SemiBold",
                          fontSize: popupHeight * 0.08,
                          color: const Color(0xFF7448ED)),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      "Comprueba tu conexión a internet antes de escanear otros productos.",
                      style: TextStyle(
                        fontFamily: "Gilroy-Medium",
                        fontSize: screenWidth * 0.045,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      controlScan(false);
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
