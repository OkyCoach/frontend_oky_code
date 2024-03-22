import 'package:flutter/material.dart';
import 'package:frontend_oky_code/widgets/details_components/stars_widget.dart';
import 'package:frontend_oky_code/widgets/v2_product_detail.dart';
import 'package:frontend_oky_code/widgets/dummy_products.dart';

class Recommended extends StatefulWidget {
  final List<dynamic> recommendedProducts;
  final bool ready;

  const Recommended({
    Key? key,
    required this.recommendedProducts,
    required this.ready,
  }) : super(key: key);

  @override
  _RecommendedState createState() => _RecommendedState();
}

class _RecommendedState extends State<Recommended> {
  void _showProductDetails(BuildContext context, dynamic product) {
    Navigator.pop(context);
    showDialog(
      barrierColor: Colors.white.withOpacity(0),
      context: context,
      builder: (BuildContext context) {
        return ProductDetailV2(
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
            if(widget.ready && widget.recommendedProducts.isNotEmpty)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: widget.recommendedProducts.map((product) {
                      return buildProduct(product, context); 
                    }).toList(), 
                  )
                )
              ),
            if(widget.ready && !widget.recommendedProducts.isNotEmpty)
              SizedBox(
                width: screenWidth,
                height: 100,
                child: const Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      "Mejor producto de la categoria.",
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: "Gilroy-Regular",
                        color: Color(0xFF201547),
                      ),
                    ),
                  )
                )
              ),

            if(!widget.ready) 
              const SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [  
                      DummyProduct(),
                      DummyProduct(),
                      DummyProduct(),
                      DummyProduct(),
                    ], 
                  )
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
                          height: 70,
                          width: 70,
                          errorBuilder: (BuildContext context, Object error,
                              StackTrace? stackTrace) {
                            return Image.asset(
                              'lib/assets/image_not_found.png',
                              height: 70,
                              width: 70,
                            );
                          },
                        )
                      : Image.asset(
                          'lib/assets/image_not_found.png', // Reemplaza con la ruta de tu imagen por defecto
                          height: 70,
                          width: 70,
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


