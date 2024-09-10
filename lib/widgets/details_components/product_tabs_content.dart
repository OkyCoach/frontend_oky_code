import 'package:flutter/material.dart';
import 'package:frontend_oky_code/widgets/details_components/table_evaluation.dart';
import 'package:frontend_oky_code/widgets/details_components/okytips.dart';
import 'package:frontend_oky_code/widgets/recommended.dart';

class ProductTabsContent extends StatelessWidget {
  final dynamic product;
  final dynamic evaluation;
  final dynamic recommendedProducts;
  final bool ready;
  final cameFromScan;

  ProductTabsContent({
    Key? key,
    required this.product,
    required this.evaluation,
    required this.recommendedProducts,
    required this.ready,
    required this.cameFromScan
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double margins = 0.04;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

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
                    minHeight: minHeight,
                  ),
                  child: Container(
                    child: evaluation["puntos_totales"] != null
                              ? TableEvaluation(evaluation: evaluation)
                              : Center(
                                  child:  Text(
                                    "Producto sin evaluación",
                                    style: TextStyle(
                                      fontSize: screenHeight * 0.02,
                                      fontFamily: "Gilroy-Medium",
                                      color: Color(0xFF201547),
                                    ),
                                  ),
                                )
                  ),
                ),
                if(evaluation["puntos_totales"] != null)
                  Recommended(
                    recommendedProducts: recommendedProducts,
                    ready: ready,
                    cameFromScan: cameFromScan,
                  ),
              ],
            ),
            ListView(
              physics: const ClampingScrollPhysics(),
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: minHeight,
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
