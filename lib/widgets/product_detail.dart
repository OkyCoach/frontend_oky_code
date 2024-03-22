import 'package:flutter/material.dart';
import 'package:frontend_oky_code/widgets/recommended.dart';
import 'package:frontend_oky_code/widgets/details_components/product_info.dart';
import 'package:frontend_oky_code/widgets/details_components/product_tabs.dart';
import 'package:frontend_oky_code/widgets/details_components/product_tabs_content.dart';

class ProductDetail extends StatelessWidget {
  final dynamic product; // Objeto con atributos variables
  final dynamic evaluation;

  const ProductDetail({
    Key? key,
    required this.product,
    required this.evaluation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
        margin: EdgeInsets.only(
            bottom: screenHeight *
                0.07), // Puedes ajustar el valor según tus necesidades
        child: Column(children: [
          DefaultTabController(
            length:
                1, // Número de pestañas (Nutricionistas y Tabla Nutricional)
            child: Dialog(
              insetPadding: const EdgeInsets.only(top: 0, left: 10, right: 10),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(
                      25), // Solo los bordes superiores son redondeados
                ),
              ),
              elevation: 10,
              backgroundColor: const Color(0xFFFFFFFF),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.9,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 4.5, // Grosor de la línea
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            2), // Establecer el radio de los bordes
                        color: const Color.fromARGB(
                            255, 201, 200, 200), // Color de la línea
                      ),
                      margin: EdgeInsets.only(
                          bottom: 10,
                          left: screenWidth * 0.4,
                          right: screenWidth * 0.4,
                          top: 8),
                    ),
                    ProductInfoRow(
                      photoUrl: product["ok_to_shop"]?["basicInformation"]
                              ?["photoUrl"] ??
                          "not_found",
                      description: product["ok_to_shop"]?["basicInformation"]
                              ?["description"] ??
                          "not_found",
                      brandName: (product["ok_to_shop"]?["basicInformation"]
                                      ?["brands"]
                                  ?.isNotEmpty ??
                              false)
                          ? (product["ok_to_shop"]["basicInformation"]["brands"]
                                  [0]["name"] ??
                              'not_found')
                          : 'not_found',
                      evaluation: evaluation,
                    ),
                    /*
                      Text(
                        "Evaluación Nutricional",
                        style: TextStyle(
                          fontSize: screenHeight * 0.022,
                          fontFamily: "Gilroy-Bold",
                        ),
                      ),
                      */
                    const ProductTabs(),
                    //ProductTabsContent(evaluation: evaluation, recommendedProducts: re,),
                  ],
                ),
              ),
            ),
          ),
          //Recommended(recommendedProducts: product)
        ]));
  }
}
