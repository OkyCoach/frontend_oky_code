import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import 'package:http/http.dart' as http; // Importa el paquete http

class ScannerPage extends StatefulWidget {
  const ScannerPage({Key? key}) : super(key: key);

  @override
  State<ScannerPage> createState() => _ScannerState();
}

class _ScannerState extends State<ScannerPage> {
  String result = '';
  // String? barcodeData; // Aquí se almacenarán los datos obtenidos
  String? imageUrl;
  String? description;
  String? allData;
  bool isLoading = false;

  Future<void> fetchBarcodeData() async {
    setState(() {
      isLoading = true;
    });
    final url =
        'https://5bc1g1a22j.execute-api.us-east-1.amazonaws.com/dev/info_producto/$result';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      setState(() {
        imageUrl = data['basicInformation']['photoUrl'];
        description = data['basicInformation']['description'];
        isLoading = false;
        allData = data.toString();
      });
    } else {
      isLoading = false;
      throw Exception('Failed to load data from server');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () async {
                var res = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SimpleBarcodeScannerPage(),
                    ));
                setState(() {
                  if (res is String) {
                    result = res;
                    fetchBarcodeData(); // Llama a la función después de escanear el barcod
                  }
                });
              },
              child: const Text('Open Scanner'),
            ),
            if (isLoading)
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              ),
            if (imageUrl != null && isLoading == false)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(
                  imageUrl!,
                  height: 400,
                ), // Muestra la imagen
              ),
            if (description != null && isLoading == false)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  description!,
                  style: TextStyle(fontSize: 18.0),
                ), // Muestra la descripción
              ),
            // desplegable de información
            if (allData != null && isLoading == false)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: SingleChildScrollView(
                            child: Column(
                              children: [
                                Text(
                                  allData!,
                                  style: TextStyle(fontSize: 18.0),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: const Text('Mostrar información completa'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
