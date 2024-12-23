import 'package:flutter/material.dart';

class ProductTabs extends StatelessWidget {
  final bool showRecipes;

  const ProductTabs({
    Key? key,
    this.showRecipes = false, // Valor por defecto
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: 35,
      child: TabBar(
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Color(0xFF7448ED), width: 4),
          ),
        ),
        labelColor: Color(0xFF7448ED),
        unselectedLabelColor: Colors.black,
        tabs: [
          Tab(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                "Evaluación Nutri",
                style: TextStyle(
                  fontFamily: "Gilroy-Medium",
                  fontSize: screenHeight * 0.02,
                ),
              ),
            ),
          ),
          Tab(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                "OkyTips",
                style: TextStyle(
                  fontFamily: "Gilroy-Medium",
                  fontSize: screenHeight * 0.02,
                ),
              ),
            ),
          ),
          if (showRecipes) // Condición para mostrar la pestaña de recetas
            Tab(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  "Recetas",
                  style: TextStyle(
                    fontFamily: "Gilroy-Medium",
                    fontSize: screenHeight * 0.02,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}