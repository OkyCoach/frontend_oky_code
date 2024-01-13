import 'package:flutter/material.dart';

class Recommended extends StatelessWidget {
  final dynamic data;

  const Recommended({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    double containerWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double itemWidth = containerWidth / 3;

    return Expanded(
      child: Container(
        color: const Color(0xFFF9F9FA), // Fondo blanco
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Text(
                  "Te recomendamos",
                  style: TextStyle(
                    fontSize: screenHeight * 0.022,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF201547),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: itemWidth,
                      child: buildProduct(screenHeight),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildProduct(double screenHeight) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.center,
          child: Image.network(
            "https://static.okto.shop/img/products/s/69/64/696474485fb0343a15488288df6a0bebff0119ec_11917.jpg",
            height: 50,
            width: 50,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Galletitas de arroz Arándano",
          style: TextStyle(
            fontSize: screenHeight * 0.015,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF201547),
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 3,
        ),
        Text(
          "MIZOS",
          style: TextStyle(
            fontSize: screenHeight * 0.015,
            fontWeight: FontWeight.normal,
            color: const Color(0xFF201547),
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        )
      ],
    );
  }
}
