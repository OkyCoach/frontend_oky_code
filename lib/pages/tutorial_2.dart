import 'package:flutter/material.dart';
import 'package:frontend_oky_code/main.dart';

class SecondTutorialPage extends StatelessWidget {
  const SecondTutorialPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double imageWidth = screenWidth / 2;
    double nutriaWidth = imageWidth * 0.8;
    double textWidth = screenWidth * 0.75;

    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Container(
            width: screenWidth,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color(0xFF201547),
                  Color(0xFF7448ED),
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight * 0.25),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.asset(
                    'lib/assets/scanner_tutorial.png',
                    width: imageWidth,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "Escanea",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    width: textWidth,
                    child: const Text(
                      "Escanea el código de barras y obtén la información nutricional de tus productos.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: screenHeight / 8,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MainPage(
                                                  showProductPopup: false, 
                                                  popUpData: {},
                                                  showNotFoundPopup: false,
                                                  )),
                );
              },
              child: Image.asset(
                'lib/assets/botones/continuar.png',
                width: nutriaWidth,
              ),
            ),
          )
        ],
      ),
    );
  }
}
