import 'package:flutter/material.dart';

class ProductTabs extends StatelessWidget {

  const ProductTabs({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return TabBar(
      indicatorSize: TabBarIndicatorSize.tab,
      indicatorColor: Color(0xFF76FDB1),
      labelColor: Colors.black,
      indicatorWeight: 8.0,
      labelPadding: EdgeInsets.symmetric(horizontal: 1.0),
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
        
      ],
    );
  }
}
