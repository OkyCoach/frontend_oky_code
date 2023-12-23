import 'package:flutter/material.dart';
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
      home: const MainPage(
        showPopup: false,
        popUpData: {},
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  final bool showPopup;
  final Map<String, dynamic> popUpData;
  const MainPage({
    Key? key, 
    required this.showPopup, 
    required this.popUpData, 
  }): super(key: key);

  @override
  State<MainPage> createState() => _MainState();
}

class _MainState extends State<MainPage> {
  int _currentIndex = 0;

  void updateIndex(int newIndex) {
    setState(() {
      _currentIndex = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool showPopup = widget.showPopup;
    final pages = [
      HomePage(
        showPopup: showPopup,
        popUpData: widget.popUpData,
      ),
      const HistoryPage(),
      const ScannerPage(),
      const OverviewPage(),
      const NutricoachPage()
    ];
    return Scaffold(
        body: pages[_currentIndex],
        bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(
            indicatorColor: const Color(0x8028144C),
            labelTextStyle: MaterialStateProperty.all(
              const TextStyle(color: Colors.white, fontSize: 10.0),
            ),
          ),
          child: CustomNavigationBar(
            currentIndex: _currentIndex,
            onUpdateIndex: updateIndex, // Pasa la función de callback
          ),
        ));
  }
}
