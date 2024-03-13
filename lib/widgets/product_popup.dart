import 'package:flutter/material.dart';
import 'package:frontend_oky_code/widgets/product_detail.dart';
import 'package:frontend_oky_code/widgets/details_components/stars_widget.dart';
import 'package:frontend_oky_code/widgets/custom_button.dart';
import 'package:frontend_oky_code/widgets/recommended.dart';

class ProductPopup extends StatelessWidget {
  final dynamic product; // Objeto con atributos variables
  final dynamic evaluation;

  const ProductPopup({
    Key? key,
    required this.product,
    required this.evaluation,
  }) : super(key: key);

  void _showProductDetails(context) {
    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ProductDetail(
          product: product,
          evaluation: evaluation,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
        margin: EdgeInsets.only(bottom: screenHeight * 0.07),
        child: Column(children: [
          SizedBox(
              width: screenWidth,
              height: screenHeight * 0.6,
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          width: 35.0,
                          height: 35.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors
                                .white, // Puedes ajustar el color según tus preferencias
                          ),
                          child: IconButton(
                            icon: Icon(
                              Icons.clear,
                              size: 20.0,
                              color: Colors.purple,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        Dialog(
                          insetPadding: const EdgeInsets.symmetric(vertical: 5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          elevation: 1,
                          child: IntrinsicHeight(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 15, top: 10, left: 15, right: 15),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      product["ok_to_shop"]?["basicInformation"]
                                                  ?["photoUrl"] !=
                                              null
                                          ? Image.network(
                                              product["ok_to_shop"]
                                                      ?["basicInformation"]
                                                  ?["photoUrl"],
                                              height: screenHeight * 0.15,
                                              width: screenHeight * 0.15,
                                              errorBuilder:
                                                  (BuildContext context,
                                                      Object error,
                                                      StackTrace? stackTrace) {
                                                return Image.asset(
                                                  'lib/assets/image_not_found.png',
                                                  height: screenHeight * 0.1,
                                                  width: screenHeight * 0.1,
                                                );
                                              },
                                            )
                                          : Image.asset(
                                              'lib/assets/image_not_found.png', // Reemplaza con la ruta de tu imagen por defecto
                                              height: screenHeight * 0.1,
                                              width: screenHeight * 0.1,
                                            ),
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                product["ok_to_shop"]?[
                                                            "basicInformation"]
                                                        ?["description"] ??
                                                    'not_found',
                                                style: TextStyle(
                                                  fontFamily: "Gilroy-SemiBold",
                                                  fontSize:
                                                      screenHeight * 0.025,
                                                  color:
                                                      const Color(0xFF7448ED),
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                              ),
                                              Text(
                                                (product["ok_to_shop"]?[
                                                                    "basicInformation"]
                                                                ?["brands"]
                                                            ?.isNotEmpty ??
                                                        false)
                                                    ? product["ok_to_shop"][
                                                                "basicInformation"]
                                                            [
                                                            "brands"][0]["name"] ??
                                                        'not_found'
                                                    : 'not_found',
                                                style: TextStyle(
                                                  fontFamily: "Gilroy-Medium",
                                                  fontSize:
                                                      screenHeight * 0.025,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 3,
                                              ),
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8),
                                                  child: StarsWidget(
                                                    maxScore: evaluation[
                                                        "puntos_totales"],
                                                    actualScore: evaluation[
                                                        "puntos_obtenidos"],
                                                    height: 0.03,
                                                  ))
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.only(top: 30),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          RoundedButton(
                                              onPressed: () {
                                                _showProductDetails(context);
                                              },
                                              buttonText: "Ver Producto",
                                              size: 180),
                                          InkWell(
                                            onTap: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: ClipOval(
                                              child: ColorFiltered(
                                                colorFilter:
                                                    const ColorFilter.mode(
                                                  Color(0xFFE8E4F4),
                                                  BlendMode.color,
                                                ),
                                                child: Image.asset(
                                                  'lib/assets/favorito.png',
                                                  height: screenHeight * 0.05,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ]))),
          //Recommended(recommendedProducts: product)
        ]));
  }
}
