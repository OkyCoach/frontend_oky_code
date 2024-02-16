import 'dart:io';
import 'package:flutter/material.dart';
import 'package:frontend_oky_code/pages/add_product/nutritional_image.dart';
import 'package:frontend_oky_code/pages/add_product/send_product.dart';
import 'package:frontend_oky_code/main.dart';

class ImagePreviewPage extends StatelessWidget {
  final dynamic data;
  const ImagePreviewPage({
    Key? key,
    required this.data,
  }) : super(key: key);

  void _nextStep(BuildContext context) async {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            data["type"] == "frontal"
                ? NutritionalImageCapture(data: data)
                : SendProductPage(
                    data: data,
                  ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0); // starting offset from right
          const end = Offset.zero;
          const curve = Curves.easeInOutQuart;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          var offsetAnimation = animation.drive(tween);

          return SlideTransition(position: offsetAnimation, child: child);
        },
      ),
    );
  }

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
          margin: const EdgeInsets.only(top: 50, left: 15, right: 15),
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
                  padding: const EdgeInsets.only(top: 25, left: 25, right: 25),
                  child: Text(
                    data["type"] == "frontal"
                        ? "Asi se verá la foto frontal"
                        : "Asi se verá la foto de la Información Nutricional",
                    style: TextStyle(
                      fontFamily: "Gilroy-Bold",
                      fontSize: screenHeight * 0.025,
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
                        InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Atras",
                          style: TextStyle(
                            fontFamily: "Gilroy-Regular",
                            fontSize: screenHeight * 0.02,
                            color: const Color(0xFF97999B),
                          ),
                        )
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) =>
                                  const MainPage(),
                              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                const begin = Offset(1.0, 0.0); // starting offset from right
                                const end = Offset.zero;
                                const curve = Curves.easeInOutQuart;

                                var tween = Tween(begin: begin, end: end)
                                    .chain(CurveTween(curve: curve));

                                var offsetAnimation = animation.drive(tween);

                                return SlideTransition(position: offsetAnimation, child: child);
                              },
                            ),
                          );
                        },
                        child: Text(
                          "Cancelar",
                          style: TextStyle(
                            fontFamily: "Gilroy-Regular",
                            fontSize: screenHeight * 0.02,
                            color: const Color(0xFF97999B),
                          ),
                        )
                      ),
                      ],
                    )),
                Expanded(
                  child: Container(
                    width: screenWidth,
                    color: Color(0xFFE8E4F4),
                    child: Image.file(
                      File(data["type"] == "frontal"
                          ? data["frontImagePath"]
                          : data[
                              "nutritionalImagePath"]), // Reemplaza 'tu_imagen.jpg' con la ruta correcta de tu imagen
                      fit: BoxFit
                          .cover, // Puedes ajustar el modo de ajuste según tus necesidades
                    ),
                  ),
                ),
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
                        InkWell(
                          onTap: () {
                            _nextStep(context);
                          },
                          child: Image.asset(
                            'lib/assets/botones/siguiente.png',
                            width: screenWidth * 0.4,
                          ),
                        )
                      ],
                    ))
              ]),
        ),
      ),
    );
  }
}
