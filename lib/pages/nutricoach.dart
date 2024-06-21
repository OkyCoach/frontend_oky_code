import 'package:flutter/material.dart';

class NutricoachPage extends StatefulWidget {
  const NutricoachPage({Key? key}) : super(key: key);

  @override
  State<NutricoachPage> createState() => _NutricoachState();
}

class _NutricoachState extends State<NutricoachPage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        width: screenWidth,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xFF201547),
              Color(0xFF7448ED),
            ],
          ),
        ),
        child: const Center(
          child: Text(
            "NutriCoach",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        )
      ),
    );
  }
}
