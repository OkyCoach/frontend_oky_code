import 'package:flutter/material.dart';
import 'package:frontend_oky_code/pages/home.dart';
import 'package:frontend_oky_code/pages/profile.dart';
import 'package:frontend_oky_code/pages/scanner.dart';
import 'package:frontend_oky_code/pages/search.dart';
import 'package:frontend_oky_code/pages/nutricoach.dart';
import 'package:frontend_oky_code/widgets/navigation_bar.dart';
import 'package:frontend_oky_code/pages/tutorial_1.dart';
import 'package:scandit_flutter_datacapture_barcode/scandit_flutter_datacapture_barcode.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ScanditFlutterDataCaptureBarcode.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Codigo Oky',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const FirstTutorialPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  final bool showProductPopup;
  final bool showNotFoundPopup;
  final Map<String, dynamic> popUpData;

  const MainPage({
    Key? key, 
    required this.showProductPopup, 
    required this.showNotFoundPopup, 
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
    bool showProductPopup = widget.showProductPopup;
    bool showNotFoundPopup = widget.showNotFoundPopup;

    final pages = [
      HomePage(
        showProductPopup: showProductPopup,
        showNotFoundPopup: showNotFoundPopup,
        popUpData: widget.popUpData,
      ),
      const ProfilePage(),
      const ScannerPage(),
      const NutricoachPage(),
      const SearchPage(),
      
    ];
    return Scaffold(
        body: pages[_currentIndex],
        bottomNavigationBar:  NavigationBarTheme(
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
