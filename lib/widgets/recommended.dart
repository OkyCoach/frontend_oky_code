import 'package:flutter/material.dart';
import 'package:frontend_oky_code/helpers/fetch_data.dart';
import 'package:frontend_oky_code/widgets/details_components/stars_widget.dart';
import 'package:frontend_oky_code/widgets/product_detail.dart';
import 'package:frontend_oky_code/widgets/dummy_products.dart';

class Recommended extends StatefulWidget {
  final List<dynamic> recommendedProducts;

  const Recommended({
    Key? key,
    required this.recommendedProducts,
  }) : super(key: key);

  @override
  _RecommendedState createState() => _RecommendedState();
}

class _RecommendedState extends State<Recommended> {
  void _showProductDetails(BuildContext context, dynamic product) {
    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ProductDetail(
          product: product["product"],
          evaluation: product["algorithm"],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double itemWidth = screenWidth / 3;

    return Container(
      width: screenWidth,
      color: const Color(0xFFF9F9FA), // Fondo blanco
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Te recomendamos",
              style: TextStyle(
                fontSize: screenHeight * 0.022,
                fontFamily: "Gilroy-Bold",
                color: const Color(0xFF201547),
              ),
            ),
            widget.recommendedProducts.isNotEmpty
              ? SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: widget.recommendedProducts.map((product) {
                      return buildProduct(product, context); 
                    }).toList(), 
                  )
                )
              : const SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [  
                    DummyProduct(),
                    DummyProduct(),
                    DummyProduct(),
                    DummyProduct(),
                    DummyProduct(),
                  ], 
                )
              )
                
          ],
        ),
      ),
    );
  }

  Widget buildProduct(dynamic product, BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      width: screenWidth / 3,
      child:GestureDetector(
        onTap: () {
          _showProductDetails(context, product);
        },
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: product["product"]["ok_to_shop"]?["basicInformation"]
                              ?["photoUrl"] !=
                          null
                      ? Image.network(
                          product["product"]["ok_to_shop"]?["basicInformation"]
                              ?["photoUrl"],
                          height: 50,
                          width: 50,
                          errorBuilder: (BuildContext context, Object error,
                              StackTrace? stackTrace) {
                            return Image.asset(
                              'lib/assets/image_not_found.png',
                              height: 50,
                              width: 50,
                            );
                          },
                        )
                      : Image.asset(
                          'lib/assets/image_not_found.png', // Reemplaza con la ruta de tu imagen por defecto
                          height: 50,
                          width: 50,
                        ),
                ),
                const SizedBox(height: 8),
                Text(
                  product["product"]["ok_to_shop"]?["basicInformation"]
                          ?["description"] ??
                      'not_found',
                  style: TextStyle(
                    fontSize: screenHeight * 0.015,
                    fontFamily: "Gilroy-Bold",
                    color: const Color(0xFF201547),
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                const SizedBox(height: 2),
                Text(
                  (product["product"]["ok_to_shop"]?["basicInformation"]
                                  ?["brands"]
                              ?.isNotEmpty ??
                          false)
                      ? product["product"]["ok_to_shop"]["basicInformation"]
                              ["brands"][0]["name"] ??
                          'not_found'
                      : 'not_found',
                  style: TextStyle(
                    fontSize: screenHeight * 0.015,
                    fontFamily: "Gilroy-Medium",
                    color: const Color(0xFF201547),
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                const SizedBox(height: 2),
                StarsWidget(
                    maxScore: product["algorithm"]["puntos_totales"],
                    actualScore: product["algorithm"]["puntos_obtenidos"],
                    height: 0.02),
              ],
            ))));
  }

  
}


