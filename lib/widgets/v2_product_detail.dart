import 'package:flutter/material.dart';

import 'package:frontend_oky_code/widgets/dismissible_bar.dart';
import 'package:frontend_oky_code/widgets/details_components/product_info.dart';
import 'package:frontend_oky_code/widgets/details_components/product_tabs.dart';
import 'package:frontend_oky_code/widgets/details_components/product_tabs_content.dart';
import 'package:frontend_oky_code/widgets/recommended.dart';
import 'package:frontend_oky_code/widgets/details_components/table_evaluation.dart';

class ProductDetailV2 extends StatefulWidget {
  final dynamic product;
  final dynamic evaluation;

  const ProductDetailV2(
      {Key? key, required this.product, required this.evaluation})
      : super(key: key);

  @override
  State<ProductDetailV2> createState() => _ProductDetailV2State();
}

class _ProductDetailV2State extends State<ProductDetailV2> {
  @override
  Widget build(BuildContext context) {
    double margins = 0.04;

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    String photoUrl = widget.product["ok_to_shop"]?["basicInformation"]
            ?["photoUrl"] ??
        "not_found";
    String description = widget.product["ok_to_shop"]?["basicInformation"]
            ?["description"] ??
        "not_found";
    String brandName = (widget
                .product["ok_to_shop"]?["basicInformation"]?["brands"]
                ?.isNotEmpty ??
            false)
        ? (widget.product["ok_to_shop"]["basicInformation"]["brands"][0]
                ["name"] ??
            'not_found')
        : 'not_found';

    return Container(
        width: double.infinity, // Ocupar todo el ancho
        color: Colors.transparent, // Fondo azul
        margin: EdgeInsets.only(bottom: screenHeight * 0.07, top: 20),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IntrinsicHeight(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: screenWidth * margins),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
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
                          photoUrl: photoUrl,
                          description: description,
                          brandName: brandName,
                          evaluation: widget.evaluation,
                        ),
                      ]),
                ),
              ),
              Expanded(
                  child: ListView(children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: screenWidth * margins),
                  child: TableEvaluation(evaluation: widget.evaluation),
                ),
                Container(
                  width: screenWidth,
                  color: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  child: Recommended(product: widget.product),
                )
                //Recommended(product: widget.product)
              ]))
            ]));
  }
}
