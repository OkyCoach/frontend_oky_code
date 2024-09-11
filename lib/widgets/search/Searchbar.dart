import 'package:flutter/material.dart';

class CustomSearchBar extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback? onSearch;

  CustomSearchBar({
    Key? key,
    required this.controller,
    required this.onSearch,
  }) : super(key: key);

  @override
  _CustomSearchBarState createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 36,
          width: screenWidth * 0.7,
          child: TextField(
            controller: widget.controller,
            textInputAction: TextInputAction.search,
            onSubmitted: (value) {
              FocusScope.of(context).unfocus();
              if (widget.onSearch != null) {
                widget.onSearch!();
              }
            },
            style: const TextStyle(
              fontFamily: "Gilroy-Medium",
              fontSize: 16,
              color: Color(0xFF201547),
            ),
            decoration: InputDecoration(
              hintText: "Escribe aquí",
              hintStyle: const TextStyle(
                color: Colors.grey,
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
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
                borderSide: const BorderSide(
                  color: Color(0xFF7448ED),
                  width: 1.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
                borderSide: const BorderSide(
                  color: Color(0xFF7448ED),
                  width: 1.0,
                ),
              ),

            ),
          ),
        ),
        SizedBox(
          height: 36,
          child: ElevatedButton(
            onPressed: () {
              FocusScope.of(context).unfocus();
              if (widget.onSearch != null) {
                widget.onSearch!();
              }
            }, // Usar la función de callback
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF7448ED),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                side: BorderSide(
                  color: Color(0xFF7448ED), // Color del borde del botón
                  width: 1.0, // Ancho del borde
                ),
              ),
            ),
            child: const Text(
              "Buscar",
              style: TextStyle(
                letterSpacing: 1,
                fontFamily: "Gilroy-Black",
                color: Colors.white,

              ),
            ),
          ),
        ),
      ],
    );
  }
}
