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
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: Color(0xFF7448ED)),
          bottom: BorderSide(color: Color(0xFF7448ED)),
        ),
      ),
      child: TabBar(
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: const BoxDecoration(
          color: Color(0xFF76FDB1),
          border: Border(
            left: BorderSide(color: Color(0xFF7448ED)),
            right: BorderSide(color: Color(0xFF7448ED)),
          ),
        ),
        labelColor: Colors.black,
        unselectedLabelColor: Colors.black,
        tabs: [
          Tab(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                "Evaluación Nutri.",
                style: TextStyle(
                  fontFamily: "Gilroy-SemiBold",
                  fontSize: screenHeight * 0.02,
                ),
              ),
            ),
          ),
          Tab(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                "Oky Tips",
                style: TextStyle(
                  fontFamily: "Gilroy-SemiBold",
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
