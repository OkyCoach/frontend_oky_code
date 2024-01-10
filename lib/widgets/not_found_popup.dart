import 'package:flutter/material.dart';

class NotFoundPopup extends StatelessWidget {
  const NotFoundPopup({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double popupHeight = screenHeight * 0.43;

    double logoHeight = screenWidth * 0.2;

    return Stack(
      alignment: AlignmentDirectional.centerStart,
      children: [
        Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          elevation: 1,
          child: SizedBox(
            height: popupHeight,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      "No pudimos encontrar el producto :(",
                      style: TextStyle(
                          fontFamily: "Gilroy-SemiBold",
                          fontSize: screenWidth*0.05,
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
                        fontSize: screenWidth*0.034,
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
                          fontSize: screenWidth*0.035,
                          color: const Color(0xFF97999B)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: (screenHeight - popupHeight - logoHeight) / 2 ,
          left: (screenWidth - logoHeight) / 2,
          child: Image.asset(
            "lib/assets/logos/logo_degrade.png",
            width: logoHeight,
          ),
        ),
      ],
    );
  }
}
