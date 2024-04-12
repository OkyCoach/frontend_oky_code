import 'package:flutter/material.dart';
import 'package:frontend_oky_code/widgets/dismissible_bar.dart';
import 'package:frontend_oky_code/widgets/details_components/product_info.dart';
import 'package:frontend_oky_code/widgets/details_components/product_tabs.dart';
import 'package:frontend_oky_code/widgets/details_components/product_tabs_content.dart';

import 'package:frontend_oky_code/helpers/fetch_data.dart';

class ProductDetailV2 extends StatefulWidget {
  final dynamic product;
  final dynamic evaluation;
  final bool scanning;
  final ValueChanged<bool> controlScan;

  const ProductDetailV2({
    Key? key,
    required this.product,
    required this.evaluation,
    required this.scanning,
    required this.controlScan,
  }) : super(key: key);

  @override
  _ProductDetailV2State createState() => _ProductDetailV2State();
}

class _ProductDetailV2State extends State<ProductDetailV2> {
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

  @override
  Widget build(BuildContext context) {
    double margins = 0.04;

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return DefaultTabController(
      length: 1,
      child: Dialog(
          backgroundColor: Colors.transparent, // Fondo azul
          insetPadding: EdgeInsets.only(bottom: screenHeight * 0.07),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                0), // Ajusta el radio según tu preferencia
          ),
          child: Dismissible(
            direction: DismissDirection.down,
            dismissThresholds: const {DismissDirection.down: 0.25},
            key: const Key('key'),
            onDismissed: (_) => {
              widget.controlScan(false),
              Navigator.of(context).pop()
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IntrinsicHeight(
                  child: Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: screenWidth * margins),
                    padding: const EdgeInsets.only(top: 10, left: 5, right: 5),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25.0),
                        topRight: Radius.circular(25.0),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const DismissibleBar(width: 40),
                        ProductInfoRow(
                          product: widget.product,
                          evaluation: widget.evaluation,
                        ),
                        const ProductTabs(),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ProductTabsContent(
                      evaluation: widget.evaluation,
                      recommendedProducts: recommendedProducts,
                      ready: ready),
                ),
              ],
            ),
          )),
    );
  }
}
