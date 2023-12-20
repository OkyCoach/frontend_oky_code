import 'package:flutter/material.dart';
import 'package:frontend_oky_code/widgets/product_popup.dart';

class HomePage extends StatefulWidget {
  final bool showPopup;
  final Map<String, dynamic> popUpData;
  const HomePage({Key? key, required this.showPopup, required this.popUpData}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    if (widget.showPopup) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _displayPopup(widget.popUpData);
      });
    }
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: null,
              child: Text('Mostrar Popup'),
            ),
          ],
        ),
      ),
    );
  }
}
