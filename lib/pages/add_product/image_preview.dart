import 'package:flutter/material.dart';

class ImagePreviewPage extends StatelessWidget {
  final String imageUrl;
  final String type;
  const ImagePreviewPage({Key? key, required this.imageUrl, required this.type,}) : super(key: key);

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
              Color(0xFF76FDB1),
              Color(0xFF7448ED),
            ],
          ),
        ),
        child: Container(
          margin: const EdgeInsets.only(top: 35, left: 15, right: 15),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.0),
              topRight: Radius.circular(25.0),
            ),
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50, left: 25, right: 25),
                  child: Text(
                    type == "frontal" ? "Asi se verá la foto frontal" : "Asi se verá la foto de la Información Nutricional",
                    style: TextStyle(
                      fontFamily: "Gilroy-Bold",
                      fontSize: screenHeight * 0.03,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(
                        top: 5, bottom: 15, left: 25, right: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Atras",
                          style: TextStyle(
                            fontFamily: "Gilroy-Regular",
                            fontSize: screenHeight * 0.02,
                            color: const Color(0xFF97999B),
                          ),
                        ),
                        Text(
                          "Cancelar",
                          style: TextStyle(
                            fontFamily: "Gilroy-Regular",
                            fontSize: screenHeight * 0.02,
                            color: const Color(0xFF97999B),
                          ),
                        ),
                      ],
                    )),
                Expanded(
                    child: Container(
                  width: screenWidth,
                  color: Color(0xFFE8E4F4),
                )),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Column(
                              children: [
                                ClipOval(
                                  child: ColorFiltered(
                                    colorFilter: const ColorFilter.mode(
                                      Color(0xFFE8E4F4),
                                      BlendMode.color,
                                    ),
                                    child: Image.asset(
                                      'lib/assets/botones/recortar.png',
                                      width: screenWidth * 0.1,
                                    ),
                                  ),
                                ),
                                Text(
                                  "Recortar",
                                  style: TextStyle(
                                    fontFamily: "Gilroy-Medium",
                                    fontSize: screenHeight * 0.015,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: screenWidth * 0.02),
                            Column(
                              children: [
                                ClipOval(
                                  child: ColorFiltered(
                                    colorFilter: const ColorFilter.mode(
                                      Color(0xFFE8E4F4),
                                      BlendMode.color,
                                    ),
                                    child: Image.asset(
                                      'lib/assets/botones/rotar.png',
                                      width: screenWidth * 0.1,
                                    ),
                                  ),
                                ),
                                Text(
                                  "Rotar",
                                  style: TextStyle(
                                    fontFamily: "Gilroy-Medium",
                                    fontSize: screenHeight * 0.015,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Image.asset(
                          'lib/assets/botones/siguiente.png',
                          width: screenWidth * 0.4,
                        ),
                      ],
                    ))
              ]),
        ),
      ),
    );
  }
}
