/*
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    title: 'Your App Title',
    home: MyApp(),
  ));
}

class MyData {
  final int id;
  final String name;
  final String status;
  final String species;

  MyData({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
  });
}

Future<List<MyData>> fetchData() async {
  final response = await http.get(Uri.parse('https://rickandmortyapi.com/api/character'));

  if (response.statusCode == 200) {
    final Map<String, dynamic> jsonResponse = json.decode(response.body);
    final List<dynamic> results = jsonResponse['results'];

    final List<MyData> characters = results
        .map((data) => MyData(
              id: data['id'],
              name: data['name'],
              status: data['status'],
              species: data['species'],
            ))
        .toList();
    return characters;
  } else {
    throw Exception('Error al cargar los datos desde la API');
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rick and Morty Characters"),
      ),
      body: FutureBuilder<List<MyData>>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.data == null) {
            return Text('No data available');
          } else {
            final characters = snapshot.data!;
            return ListView.builder(
              itemCount: characters.length,
              itemBuilder: (context, index) {
                final character = characters[index];
                return ListTile(
                  title: Text(character.name),
                  subtitle: Text('ID: ${character.id}, Status: ${character.status}, Species: ${character.species}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
*/
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
        imageUrl = data['photoUrl'];
        description = data['description'];
        isLoading = false;
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
          ],
        ),
      ),
    );
  }
}
