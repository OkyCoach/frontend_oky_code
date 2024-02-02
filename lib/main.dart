import 'package:flutter/material.dart';
import 'package:frontend_oky_code/pages/home.dart';
import 'package:frontend_oky_code/pages/profile.dart';
import 'package:frontend_oky_code/pages/user/signup.dart';
import 'package:frontend_oky_code/widgets/scandit_scanner.dart';
import 'package:frontend_oky_code/pages/search.dart';
import 'package:frontend_oky_code/pages/nutricoach.dart';
import 'package:frontend_oky_code/widgets/navigation_bar.dart';
import 'package:frontend_oky_code/pages/tutorial_1.dart';
import 'package:frontend_oky_code/pages/user/login.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:scandit_flutter_datacapture_barcode/scandit_flutter_datacapture_barcode.dart';
import 'package:permission_handler/permission_handler.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScanditFlutterDataCaptureBarcode.initialize();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isFirstTime = prefs.getBool('isFirstTime') ?? true;

  // pregunta por permisos de camara
  PermissionStatus status = await Permission.camera.status;
  if (!status.isGranted) {
    await Permission.camera.request();
  }

  runApp(MyApp(isFirstTime: isFirstTime));
}

class MyApp extends StatelessWidget {
  final bool isFirstTime;

  const MyApp({Key? key, required this.isFirstTime}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Codigo Oky',
      theme: ThemeData(useMaterial3: true),
      home: isFirstTime ? const FirstTutorialPage() : const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  
  const MainPage({
    Key? key, 
  }): super(key: key);
  @override
  State<MainPage> createState() => _MainState();
}

class _MainState extends State<MainPage> {
  int _currentIndex = 2;

  void updateIndex(int newIndex) {
    setState(() {
      _currentIndex = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {

    final pages = [
      const HomePage(),
      const ProfilePage(),
      BarcodeScannerScreen(),
      const NutricoachPage(),
      const SearchPage(), 
    ];
    return Scaffold(
        body: pages[_currentIndex],
        bottomNavigationBar:  NavigationBarTheme(
          
              data: NavigationBarThemeData(
                indicatorColor: Colors.transparent,
                indicatorShape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                   // Puedes ajustar el radio de las esquinas
                ),
                
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
