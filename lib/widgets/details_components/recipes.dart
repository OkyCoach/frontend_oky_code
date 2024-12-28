import 'package:flutter/material.dart';
import 'dart:math';
import 'package:frontend_oky_code/helpers/fetch_data.dart';
import 'package:frontend_oky_code/widgets/details_components/recipes-components/image.dart';
import 'package:frontend_oky_code/widgets/details_components/recipes-components/ingredients.dart';
import 'package:frontend_oky_code/widgets/details_components/recipes-components/nutritional.dart';

class Recipes extends StatefulWidget {
  final dynamic recipe;
  const Recipes({
    Key? key,
    required this.recipe,
  }) : super(key: key);

  @override
  _RecipesState createState() => _RecipesState();
}

class _RecipesState extends State<Recipes> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      color: const Color(0xFFE8E4F4),
      padding: const EdgeInsets.only(top: 20, bottom: 16,  left: 10, right: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.recipe["title"] ?? "Not found",
                  style: TextStyle(
                    fontFamily: "Gilroy-Bold",
                    fontSize: screenHeight * 0.023,
                    color: Color(0xFF7448ED),
                    height: 1.1,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Text(
                  "Porciones: ${widget.recipe["portions"] ?? "-"}",
                  style: TextStyle(
                    fontFamily: "Gilroy-Regular",
                    fontSize: screenHeight * 0.018,
                    color: Colors.grey[800],
                    height: 1.8,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                ClickableImage(
                  imageUrl: widget.recipe["imgUrl"],
                  link: widget.recipe["recipeLink"],
                ),
                SizedBox(height: 20,),
                NutritionalValues(values: widget.recipe["nutritionalFacts"]),
                SizedBox(height: 20,),
                Ingredients(ingredients: widget.recipe["ingredients"])
              ],
            ),
          ),
        ],
      ),
    );
  }
}
