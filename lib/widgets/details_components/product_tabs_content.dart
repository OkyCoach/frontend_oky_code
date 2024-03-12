import 'package:flutter/material.dart';
import 'package:frontend_oky_code/widgets/details_components/nutricionist_evaluation.dart';
import 'package:frontend_oky_code/widgets/details_components/table_evaluation.dart';

class ProductTabsContent extends StatelessWidget {
  final dynamic evaluation;

  const ProductTabsContent({
    Key? key,
    required this.evaluation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return 
      TabBarView(
        children: [
          TableEvaluation(evaluation: evaluation),
        ],
      );
   
  }
}
