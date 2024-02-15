import 'package:flutter/material.dart';
import 'package:frontend_oky_code/helpers/fetch_data.dart';
import 'package:frontend_oky_code/widgets/details_components/stars_widget.dart';
import 'package:frontend_oky_code/widgets/product_detail.dart';

class Recommended extends StatefulWidget {
  final dynamic product;

  const Recommended({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  _RecommendedState createState() => _RecommendedState();
}

class _RecommendedState extends State<Recommended> {
  List<dynamic> recommendedProducts = [];
  bool ready = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      List<dynamic> products =
          await fetchRecommendedProducts(widget.product["barcode"]);
      setState(() {
        recommendedProducts = products;
        ready = true;
      });
    } catch (error) {
      print("Error al obtener los productos recomendados: $error");
    }
  }

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
    double containerWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double itemWidth = containerWidth / 3;

    return Expanded(
      child: Container(
        width: containerWidth,
        color: const Color(0xFFF9F9FA), // Fondo blanco
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Text(
                  "Te recomendamos",
                  style: TextStyle(
                    fontSize: screenHeight * 0.022,
                    fontFamily: "Gilroy-Bold",
                    color: const Color(0xFF201547),
                  ),
                ),
              ),
              if (!ready)
                const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              if (ready && recommendedProducts.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: recommendedProducts.length,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        width: itemWidth,
                        child: buildProduct(
                            screenHeight, recommendedProducts[index], context),
                      );
                    },
                  ),
                ),
              if (ready && !recommendedProducts.isNotEmpty)
                Expanded(
                  child: Center(
                    child: Text(
                      "Mejor producto de la categoría",
                      style: TextStyle(
                        fontSize: screenHeight * 0.018,
                        fontFamily: "Gilroy-Regular",
                        color: const Color(0xFF201547),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildProduct(
      double screenHeight, dynamic product, BuildContext context) {
    return GestureDetector(
        onTap: () {
          _showProductDetails(context, product);
        },
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
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
                StarsWidget(
                    maxScore: product["algorithm"]["puntos_totales"],
                    actualScore: product["algorithm"]["puntos_obtenidos"],
                    height: 0.02),
              ],
            )));
  }
}
