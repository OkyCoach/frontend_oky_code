import 'package:flutter/material.dart';
import 'package:frontend_oky_code/widgets/product_popup.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  // Método para mostrar el popup
  void _mostrarPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const ProductPopup(
          data: {
            'Atributo1': 'Valor1',
            'Atributo2': 'Valor2',
            // Puedes agregar más atributos según tus necesidades
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: _mostrarPopup,
              child: const Text('Mostrar Popup'),
            ),
          ],
        ),
      ),
    );
  }
}
