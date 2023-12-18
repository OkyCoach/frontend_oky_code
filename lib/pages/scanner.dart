import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend_oky_code/main.dart';
import 'package:frontend_oky_code/widgets/product_popup.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import 'package:http/http.dart' as http;

class ScannerPage extends StatefulWidget {
  const ScannerPage({Key? key}) : super(key: key);

  @override
  State<ScannerPage> createState() => _ScannerState();
}

class _ScannerState extends State<ScannerPage> {
  String result = '';
  String? imageUrl;
  String? description;
  String? allData;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    // Llamada a la función que deseas ejecutar al cargar la vista
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadScannerPage();
    });
  }

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

  Future<void> _loadScannerPage() async {
    var res = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SimpleBarcodeScannerPage(),
      ),
    );
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const MainPage(),
      ),
      (route) => false, // Remove all existing routes from the stack
    );
    if (res == "-1") {
      result = res;
      var data = await fetchBarcodeData(); // Llama a la función después de escanear el código de barras
    }
    
  }

  

  Future<Map<String, dynamic>> fetchBarcodeData() async {
    setState(() { isLoading = true; });

    const url = 'https://5bc1g1a22j.execute-api.us-east-1.amazonaws.com/dev/info_producto/7802910008052';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data;
      } else {
        setState(() { isLoading = false; });
      }
    } catch (error) {
      setState(() { isLoading = false; });
      return {"error": "Ocurrio un error al buscar los datos"};
    }
    return {"error": "Ocurrio un error al buscar los datos"};
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      
    );
  }
}
