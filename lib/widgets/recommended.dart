import 'package:flutter/material.dart';

class Recommended extends StatelessWidget {
  final dynamic data;

  const Recommended({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double containerHeight = screenHeight * 0.25;
    double containerWidth = MediaQuery.of(context).size.width;

    // Calcula el ancho para cada elemento dividiendo el ancho total entre el número total de elementos (4 en este caso).
    double itemWidth = containerWidth / 3;

    return Container(
      height: containerHeight,
      color: const Color(0xFFFFFFFF),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 5),
              child: Text(
                "Te recomendamos",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF201547),
                ),
              ),
            ),
            SizedBox(
              height: containerHeight * 0.7,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                itemBuilder: (context, index) {
                  return SizedBox(
                    width: itemWidth,
                    child: buildProduct(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProduct() {
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
        const Text(
          "Galletitas de arroz Arándano",
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: Color(0xFF201547),
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 3,
        ),
        const Text(
          "MIZOS",
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.normal,
            color: Color(0xFF201547),
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        )
      ],
    );
  }
}
