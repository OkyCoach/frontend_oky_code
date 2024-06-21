import 'package:flutter/material.dart';
import 'package:frontend_oky_code/pages/tutorial_2.dart';

import 'package:shared_preferences/shared_preferences.dart';

class FirstTutorialPage extends StatelessWidget {
  const FirstTutorialPage({Key? key}): super(key: key);

  void _completeTutorial(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstTime', false);

    // Después de actualizar isFirstTime, puedes navegar a la siguiente pantalla o realizar otras acciones.
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
          SecondTutorialPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0); // starting offset from right
          const end = Offset.zero;
          const curve = Curves.easeInOutQuart;

          var tween = Tween(begin: begin, end: end)
              .chain(CurveTween(curve: curve));

          var offsetAnimation = animation.drive(tween);

          return SlideTransition(position: offsetAnimation, child: child);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double imageWidth = screenWidth / 2;

    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Container(
            width: screenWidth,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color(0xFF201547),
                  Color(0xFF7448ED),
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight * 0.25),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.asset(
                    'lib/assets/logos/full_logo.png',
                    width: imageWidth,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "¡Bienvenid@!",
                    style: TextStyle(
                      fontSize: screenHeight * 0.035,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: SizedBox(
                    width: screenWidth * 0.9,
                    child: Text(
                      "Estamos Oky Life para comenzar tu revolución nutricional. Desliza para conocer más.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: screenHeight * 0.022,
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: InkWell(
                    onTap: () {
                      _completeTutorial(context);
                    },
                    child: Image.asset(
                      'lib/assets/botones/comenzar.png',
                      width: imageWidth,
                    ),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            bottom: -(screenWidth - 50) / 2,
            child: Image.asset(
              'lib/assets/nutria_1.png',
              width: screenWidth,
            ),
          ),
          
        ],
      ),
    );
  }
}
