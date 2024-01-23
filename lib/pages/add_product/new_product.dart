import 'package:flutter/material.dart';
import 'package:frontend_oky_code/widgets/custom_input.dart';

class NewProductPage extends StatelessWidget {
  const NewProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: screenWidth,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF76FDB1),
              Color(0xFF7448ED),
            ],
          ),
        ),
        child: Container(
          margin: const EdgeInsets.only(top: 35, left: 15, right: 15),
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 25),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.0),
              topRight: Radius.circular(25.0),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Información General",
                style: TextStyle(
                  fontFamily: "Gilroy-Bold",
                  fontSize: screenHeight * 0.03,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Atras",
                      style: TextStyle(
                        fontFamily: "Gilroy-Regular",
                        fontSize: screenHeight * 0.02,
                        color: const Color(0xFF97999B),
                      ),
                    ),
                    Text(
                      "Cancelar",
                      style: TextStyle(
                        fontFamily: "Gilroy-Regular",
                        fontSize: screenHeight * 0.02,
                        color: const Color(0xFF97999B),
                      ),
                    ),
                  ],
                )
              ),
              const CustomInputField(title: "Nombre del producto"),
              const CustomInputField(title: "Marca"),
              Padding(
                padding:const EdgeInsets.only(top: 25),
                child: Image.asset(
                  'lib/assets/botones/siguiente.png',
                  width: screenWidth * 0.5,
                ),
              )
            ]
          ),
        ),
      ),
    );
  }
}
