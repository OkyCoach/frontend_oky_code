import 'package:flutter/material.dart';

class ProductTabs extends StatelessWidget {

  const ProductTabs({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: 35,
      child:TabBar(
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: const BoxDecoration(
          color: Color(0xFF76FDB1),
        ),
        labelColor: Colors.black,
        tabs: [
          Tab(
            child: Text(
              "Evaluación Nutricional",
              style: TextStyle(
                fontFamily: "Gilroy-SemiBold",
                fontSize: screenHeight * 0.02,
              ),
            ),
          ),
          Tab(
            child: Text(
              "Oky Tips",
              style: TextStyle(
                fontFamily: "Gilroy-SemiBold",
                fontSize: screenHeight * 0.02,
              ),
            ),
          ),
        ],
      )
    );
  }
}
