import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend_oky_code/pages/home.dart';
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
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    // Llamada a la función que deseas ejecutar al cargar la vista
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _loadScannerPage();
    });
  }

  Future<void> _loadScannerPage() async {
    var res = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SimpleBarcodeScannerPage(),
      ),
    );

    setState(() {
      if (res == "-1") {
        print("HOLAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
        print(res);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
      } else if (res is String) {
        result = res;
        fetchBarcodeData(); // Llama a la función después de escanear el código de barras
      }
    });
  }

  Future<void> fetchBarcodeData() async {
    setState(() {
      isLoading = true;
    });

    final url =
        'https://5bc1g1a22j.execute-api.us-east-1.amazonaws.com/dev/info_producto/$result';
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        setState(() {
          imageUrl = data['photoUrl'];
          description = data['description'];
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (error) {
      print('Error fetching data: $error');
      setState(() {
        isLoading = false;
      });
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
              onPressed: () => _loadScannerPage(),
              child: const Text('Open Scanner'),
            ),
            if (isLoading)
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              ),
            if (imageUrl != null && !isLoading)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(
                  imageUrl!,
                  height: 400,
                ),
              ),
            if (description != null && !isLoading)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  description!,
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
