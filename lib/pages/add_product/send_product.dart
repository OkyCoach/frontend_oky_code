import 'package:flutter/material.dart';

class SendProductPage extends StatelessWidget {
  const SendProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: screenWidth,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF201547),
              Color(0xFF7448ED),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 45),
              child: Image.asset(
                'lib/assets/logos/mano_oky.png',
                width: screenWidth * 0.4,
              ),
            ),
            Text(
              "¡Gracias por contribuir con la comunidad Oky Life!",
              style: TextStyle(
                fontFamily: "Gilroy-Bold",
                fontSize: screenHeight * 0.03,
                color: Colors.white
              ),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 36),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.check,
                    color: Colors.white,
                    size: screenHeight * 0.02,
                  ), // Espacio entre el icono y el texto
                  Expanded(
                    child: Text(
                      "Asegúrate que la información sea correcta, será compartida con la comunidad.",
                      style: TextStyle(
                        fontFamily: "Gilroy-Regular",
                        fontSize: screenHeight * 0.02,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 36),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.check,
                    color: Colors.white,
                    size: screenHeight * 0.02,
                  ), // Espacio entre el icono y el texto
                  Expanded(
                    child: Text(
                      "Sólo agrega alimentos y bebestibles.",
                      style: TextStyle(
                        fontFamily: "Gilroy-Regular",
                        fontSize: screenHeight * 0.02,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
  
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: Image.asset(
                'lib/assets/botones/enviar.png',
                width: screenWidth * 0.4,
              ),
            )
          ]
        ),
      ),
    );
  }
}
