import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key, 
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomeState();
}

class _HomeState extends State<HomePage> {

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
          child: 
              Text(
                "Pagina principal",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w100,
                  color: Colors.white,
                ),
              ),
              
          
        )
      ),
    );
  }
}
