import 'package:flutter/material.dart';
import 'package:frontend_oky_code/widgets/dismissible_bar.dart';
import 'package:frontend_oky_code/widgets/details_components/product_info.dart';
import 'package:frontend_oky_code/widgets/details_components/product_tabs.dart';
import 'package:frontend_oky_code/widgets/details_components/product_tabs_content.dart';


class ProductDetailV3 extends StatefulWidget {
  final dynamic product;
  final dynamic evaluation;
  final List<dynamic> recommendedProducts;
  final bool isLiked;
  final ValueChanged<bool> changeLike;
  final bool ready;
  final ValueChanged<bool> showDetails;
  final ValueChanged<bool> scanning;
  final Future<bool> Function(dynamic)? changeProduct;

  const ProductDetailV3({
    Key? key,
    required this.product,
    required this.evaluation,
    required this.isLiked,
    required this.changeLike,
    required this.recommendedProducts,
    required this.ready,
    required this.showDetails,
    required this.scanning,
    this.changeProduct,
  }) : super(key: key);

  @override
  _ProductDetailV3State createState() => _ProductDetailV3State();
}

class _ProductDetailV3State extends State<ProductDetailV3> {
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

    return DefaultTabController(
          length: 2,
          child: Dismissible(
            direction: DismissDirection.down,
            dismissThresholds: const {DismissDirection.down: 0.25},
            key: const Key('key'),
            onDismissed: (_) => {
              widget.showDetails(false),
              widget.scanning(true)
            },
            child:  Container(
              width: screenWidth * 0.97,
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
                    isLiked: widget.isLiked,
                    changeLike: widget.changeLike,
                  ),
                  const ProductTabs(),
                  Expanded(
                    child: ProductTabsContent(
                      product: widget.product,
                      evaluation: widget.evaluation,
                      recommendedProducts: widget.recommendedProducts,
                      ready: widget.ready,
                      cameFromScan: true,
                      changeProduct: widget.changeProduct,
                    ),
                  ),
                ],
              )
            )
          )
    );

  }
}
