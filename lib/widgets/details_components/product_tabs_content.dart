import 'package:flutter/material.dart';
import 'package:frontend_oky_code/widgets/details_components/table_evaluation.dart';
import 'package:frontend_oky_code/widgets/details_components/okytips.dart';
import 'package:frontend_oky_code/widgets/recommended.dart';

class ProductTabsContent extends StatelessWidget {
  final dynamic product;
  final dynamic evaluation;
  final dynamic recommendedProducts;
  final bool ready;
  final bool scanning;
  final ValueChanged<bool> controlScan;
  final cameFromScan;

  ProductTabsContent({
    Key? key,
    required this.product,
    required this.evaluation,
    required this.recommendedProducts,
    required this.ready,
    required this.scanning,
    required this.controlScan,
    required this.cameFromScan
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double margins = 0.04;
    double screenWidth = MediaQuery.of(context).size.width;

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double minHeight = constraints.maxHeight;

        return TabBarView(
          children: [
            ListView(
              physics: const ClampingScrollPhysics(),
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: minHeight, // Establece la altura mínima al espacio disponible
                  ),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: screenWidth * margins),
                    child: TableEvaluation(evaluation: evaluation),
                  ),
                ),
                Recommended(
                  recommendedProducts: recommendedProducts,
                  ready: ready,
                  scanning: scanning,
                  controlScan: controlScan,
                  cameFromScan: cameFromScan,
                ),
              ],
            ),
            ListView(
              physics: const ClampingScrollPhysics(),
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: minHeight, // Establece la altura mínima al espacio disponible
                  ),
                  child: OkyTips(
                    product: product,
                  ),
                ),
              ]
            )
          ],
        );
      },
    );
  }
}
