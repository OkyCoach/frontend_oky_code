import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final TextEditingController controller;
  final String title;

  const CustomInputField({
    Key? key,
    required this.controller,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: TextStyle(
              fontFamily: "Gilroy-Semibold",
              fontSize: screenHeight * 0.025,
              color: const Color(0xFF7448ED),
            ),
          ),
          SizedBox(
            height: 40, // Ajusta la altura del SizedBox según tus necesidades
            child: TextField(
              controller: controller,
              style: const TextStyle(
                fontFamily: "Gilroy-Medium",
                fontSize: 16,
                color: Color.fromARGB(255, 7, 6, 7),
              ),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(bottom: 16.0, left: 10, right: 10),
                filled: true,
                fillColor: const Color(0xFFE8E4F4), // Color de fondo gris
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(60.0), // Bordes redondos
                  borderSide: BorderSide.none, // Sin contorno
                ),
              ),
              
            ),
          ),
        ],
      ),
    );
  }
}
