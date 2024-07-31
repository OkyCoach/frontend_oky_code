import 'package:flutter/material.dart';
import 'package:frontend_oky_code/pages/home.dart';
import 'package:frontend_oky_code/pages/ profile.dart';
import 'package:frontend_oky_code/pages/search.dart';
import 'package:frontend_oky_code/pages/nutricoach.dart';
import 'package:frontend_oky_code/widgets/navigation_bar.dart';
import 'package:frontend_oky_code/pages/tutorial_1.dart';
import 'package:frontend_oky_code/pages/user/sign_in.dart';
import 'package:frontend_oky_code/helpers/auth_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend_oky_code/widgets/new_scanner.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName:'lib/.env');

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isFirstTime = prefs.getBool('isFirstTime') ?? true;

  // Use AuthService to check if the user is logged in
  bool isLogged = await AuthManager().isLoggedIn();

  // Request camera permissions
  PermissionStatus status = await Permission.camera.status;
  if (!status.isGranted) {
    await Permission.camera.request();
  }

  runApp(MyApp(isFirstTime: isFirstTime, isLogged: isLogged));
}

class MyApp extends StatelessWidget {
  final bool isFirstTime;
  final bool isLogged;

  const MyApp({Key? key, required this.isFirstTime, required this.isLogged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Codigo Oky',
      theme: ThemeData(useMaterial3: true),
      home: isFirstTime
          ? FirstTutorialPage()
          : (isLogged ? MainPage() : SignInPage()),
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
  int _currentIndex = 0;

  void updateIndex(int newIndex) {
    setState(() {
      _currentIndex = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      //const HomePage(),|
      MyScannerWidget(),
      const ProfilePage(),
      //BarcodeScannerScreen(),
      //const NutricoachPage(),
      //const SearchPage(),
    ];
    return Scaffold(
        body: pages[_currentIndex],
        bottomNavigationBar: NavigationBarTheme(
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
