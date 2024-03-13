import 'package:flutter/material.dart';
import 'package:frontend_oky_code/widgets/details_components/table_evaluation.dart';
import 'package:frontend_oky_code/widgets/recommended.dart';

class ProductTabsContent extends StatelessWidget {
  final dynamic evaluation;
  final dynamic recommendedProducts;

  const ProductTabsContent({
    Key? key,
    required this.evaluation,
    required this.recommendedProducts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double margins = 0.04;
    double screenWidth = MediaQuery.of(context).size.width;

    return TabBarView(
      children: [
        ListView(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: screenWidth * margins),
              child: TableEvaluation(evaluation: evaluation),
            ),
            Recommended(recommendedProducts: recommendedProducts)
          ],
        ),
        const Text("OkyTips")
      ],
    );
  }
}
