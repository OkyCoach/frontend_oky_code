import 'package:flutter/material.dart';
//import 'package:frontend_oky_code/pages/scanner.dart';
import 'package:frontend_oky_code/pages/home.dart';
import 'package:frontend_oky_code/pages/history.dart';
import 'package:frontend_oky_code/pages/scanner.dart';
import 'package:frontend_oky_code/pages/overview.dart';
import 'package:frontend_oky_code/pages/nutricoach.dart';
import 'package:frontend_oky_code/widgets/navigation_bar.dart';

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
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainState();
}

class _MainState extends State<MainPage> {
  int _currentIndex = 0;
  final pages = [
    HomePage(), 
    HistoryPage(),
    ScannerPage(),
    OverviewPage(),
    NutricoachPage()
  ];
  void updateIndex(int newIndex) {
    setState(() {
      _currentIndex = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: CustomNavigationBar(
        currentIndex: _currentIndex,
        onUpdateIndex: updateIndex, // Pasa la función de callback
      ),
    );
  }
}