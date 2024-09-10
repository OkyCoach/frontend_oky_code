import 'package:flutter/material.dart';

class CustomSearchBar extends StatefulWidget {
  final TextEditingController controller;
  CustomSearchBar({
    Key? key,
    required this.controller
  }) : super(key: key);

  @override
  _CustomSearchBarState createState() => _CustomSearchBarState();
}
class _CustomSearchBarState extends State<CustomSearchBar> {

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    double screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    return SizedBox(
      height: 36,
      width: screenWidth * 0.9,
      child: TextField(
        controller: widget.controller,
        style: const TextStyle(
          fontFamily: "Gilroy-Medium",
          fontSize: 14,
          color: Color(0xFF201547),
        ),
        decoration: InputDecoration(
          hintText: "Nombre, marca o código de barras del producto.",
          hintStyle: const TextStyle(
            color: Colors.grey, // Color del placeholder
            fontFamily: "Gilroy-Medium",
            fontSize: 14,
          ),
          contentPadding: const EdgeInsets.only(bottom: 16.0, left: 10, right: 10),
          filled: true,
          fillColor: Colors.white,
          prefixIcon: const Icon(
            Icons.search,
            color: Colors.grey,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Color(0xFF8A2BE2),
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Color(0xFF7448ED),
              width: 1.0,
            ),
          ),
        ),
      ),
    );
  }
}