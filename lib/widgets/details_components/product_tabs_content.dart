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
    return Expanded(
      child: TabBarView(
        children: [
          /*
          // Contenido de la pestaña Nutricionistas
          ListView(
            children: [
              NutricionistEvaluation(product: product),
            ],
          ),
          */
          // Contenido de la pestaña Tabla Nutricional
          ListView(
            children: [
              TableEvaluation(evaluation: evaluation),
            ],
          ),
        ],
      ),
    );
  }
}
