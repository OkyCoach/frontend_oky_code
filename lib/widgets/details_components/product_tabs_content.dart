import 'package:flutter/material.dart';
import 'package:frontend_oky_code/widgets/nutricionist_evaluation.dart';
import 'package:frontend_oky_code/widgets/table_evaluation.dart';

class ProductTabsContent extends StatelessWidget {
  final dynamic data;

  const ProductTabsContent({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Expanded(
      child: TabBarView(
        children: [
          // Contenido de la pestaña Nutricionistas
          ListView(
            children: [
              NutricionistEvaluation(data: data),
            ],
          ),

          // Contenido de la pestaña Tabla Nutricional
          ListView(
            children: [
              TableEvaluation(data: data),
            ],
          ),
        ],
      ),
    );
  }
}
