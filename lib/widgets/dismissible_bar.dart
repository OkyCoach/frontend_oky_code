import 'package:flutter/material.dart';

class DismissibleBar extends StatelessWidget {
  final double width;
  const DismissibleBar({Key? key, required this.width}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 4.5,
      width: width,
      margin: const EdgeInsets.only(bottom: 10), // Grosor de la línea
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        color: const Color(0xFF97999B),
      ),
    );
  }
}
