import 'package:flutter/material.dart';
//import 'package:frontend_oky_code/pages/scanner.dart';
import 'package:frontend_oky_code/pages/home.dart';
import 'package:frontend_oky_code/pages/scanner.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      routes: {
        '/scanner': (context) => ScannerPage(), // Define la ruta a ScannerPage
      },
    );
  }
}