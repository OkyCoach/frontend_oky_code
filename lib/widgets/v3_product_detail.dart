import 'package:flutter/material.dart';
import 'package:frontend_oky_code/widgets/dismissible_bar.dart';
import 'package:frontend_oky_code/widgets/details_components/product_info.dart';
import 'package:frontend_oky_code/widgets/details_components/product_tabs.dart';
import 'package:frontend_oky_code/widgets/details_components/product_tabs_content.dart';

import 'package:frontend_oky_code/helpers/fetch_data.dart';

class ProductDetailV3 extends StatefulWidget {
  final dynamic product;
  final dynamic evaluation;

  const ProductDetailV3({
    Key? key,
    required this.product,
    required this.evaluation,
  }) : super(key: key);

  @override
  _ProductDetailV3State createState() => _ProductDetailV3State();
}

class _ProductDetailV3State extends State<ProductDetailV3> {
  List<dynamic> recommendedProducts = [];
  bool ready = false;
  bool isVisible = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double margins = 0.04;

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return isVisible
      ? DefaultTabController(
          length: 2,
          child: Dismissible(
            direction: DismissDirection.down,
            dismissThresholds: const {DismissDirection.down: 0.25},
            key: const Key('key'),
            onDismissed: (_) => {
              setState(() {
                isVisible = false;
              })
            },
            child:  Container(
              width: screenWidth*0.95,
              height: screenHeight*0.8,
              padding: const EdgeInsets.only(top: 10),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.0),
                  topRight: Radius.circular(25.0),
                ),
              ),
              child: Column(
                children: [
                  const DismissibleBar(width: 40),
                  ProductInfoRow(
                    product: widget.product,
                    evaluation: widget.evaluation,
                  ),
                  const ProductTabs(),
                  Expanded(
                    child: ProductTabsContent(
                      product: widget.product,
                      evaluation: widget.evaluation,
                      recommendedProducts: recommendedProducts,
                      ready: ready,
                      cameFromScan: true,
                    ),
                  ),
                ],
              )
            )
          )
    )
      : SizedBox.shrink();
  }
}
