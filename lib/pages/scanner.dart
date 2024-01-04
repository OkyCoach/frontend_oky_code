import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend_oky_code/main.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import 'package:http/http.dart' as http;

import 'package:frontend_oky_code/widgets/scandit_scanner.dart';

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

  Future<void> _loadScannerPage() async {
    var res = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BarcodeScannerScreen(),
      ),
    );
    if (res == "-1") {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => MainPage(
            showProductPopup: false,
            showNotFoundPopup: false,
            popUpData: {},
          ),
        ),
        (route) => false, // Remove all existing routes from the stack
      ); 
    } else {
      var data = await fetchBarcodeData(res);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => MainPage(
            showProductPopup: data["barcode"] != null,
            showNotFoundPopup: !(data["barcode"] != null),
            popUpData: data,
          ),
        ),
        (route) => false, // Remove all existing routes from the stack
      );
    }
    
  }

  

  Future<Map<String, dynamic>> fetchBarcodeData(String code) async {
  setState(() { isLoading = true; });

  const url = 'https://5bc1g1a22j.execute-api.us-east-1.amazonaws.com/dev/info_producto/';
  try {
    final response = await http.get(Uri.parse('$url$code'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data;
    } else {
      setState(() { isLoading = false; });
      return {"error": "Error en la solicitud HTTP"};
    }
  } catch (error) {
    setState(() { isLoading = false; });
    return {"error": "Ocurrió un error al buscar los datos"};
  }
}


  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      
    );
  }
}
