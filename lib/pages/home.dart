import 'package:flutter/material.dart';
import 'package:frontend_oky_code/widgets/product_popup.dart';
import 'package:frontend_oky_code/widgets/not_found_popup.dart';
import 'package:frontend_oky_code/widgets/recommended.dart';

class HomePage extends StatefulWidget {
  final bool showProductPopup;
  final bool showNotFoundPopup;
  final Map<String, dynamic> popUpData;
  const HomePage({
    Key? key, 
    required this.showProductPopup, 
    required this.showNotFoundPopup,
    required this.popUpData})
      : super(key: key);

  @override
  State<HomePage> createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  // Método para mostrar el popup
  void _displayPopup(data) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ProductPopup(
          data: data,
        );
      },
    );
  }

  void _displayNotFound() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const NotFoundPopup();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    if (widget.showProductPopup) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _displayPopup(widget.popUpData);
      });
    }
    if(widget.showNotFoundPopup){
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _displayNotFound();
      });
    }

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
            "Pagina principal",
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
