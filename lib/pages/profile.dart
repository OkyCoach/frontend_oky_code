import 'package:flutter/material.dart';
import 'package:frontend_oky_code/helpers/auth_manager.dart';
import 'dart:convert';
import 'package:frontend_oky_code/main.dart';
import 'package:frontend_oky_code/widgets/custom_button.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfileState();
}

class _ProfileState extends State<ProfilePage> {
  Future<Map<String, String>>? _userDataFuture;

  @override
  void initState() {
    super.initState();
    _userDataFuture = AuthManager().getSession();
  }

  void _logout() async {
    // Perform logout logic
    await AuthManager().clearSession();
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => MyApp(isFirstTime: false, isLogged: false)));
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: SingleChildScrollView(
            child:  Container(
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
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                      child: Image.asset(
                    'lib/assets/logos/full_logo.png',
                    width: 200,
                  )),
                  const Text(
                    'Tu Perfil:',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FutureBuilder<Map<String, String>>(
                    future: _userDataFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (snapshot.hasData) {
                        final userData = snapshot.data!;
                        if (userData.containsKey('userInfo') &&
                            userData['userInfo'] != null) {
                          Map<String, dynamic> userInfo =
                              json.decode(userData['userInfo']!);
                          return Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.white), // Añade un borde blanco
                              borderRadius: BorderRadius.circular(
                                  10), // Opcional: Añade bordes redondeados
                              color: const Color(0xFF7448ED), // Fondo transparente
                            ),
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${userInfo['name']} ${userInfo['family_name']}',
                                  style: const TextStyle(
                                    fontSize: 24,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  userInfo['email'],
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return Text('No data available');
                        }
                        
                      } else {
                        return Text('No data available');
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Acerca de Okylife:',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      RichText(
                        textAlign: TextAlign.justify,
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: "- Si deseas saber como respaldamos nuestra evaluacion, te invitamos a ver nuestro ",
                              style: TextStyle(
                                fontFamily: "Gilroy-Medium",
                                fontSize: 18,
                                color: const Color(0xFF201547),
                              ),
                            ),
                            TextSpan(
                              text: "algoritmo de evaluación de productos.",
                              style: const TextStyle(
                                decoration: TextDecoration.underline,
                                fontFamily: "Gilroy-Medium",
                                fontSize: 18,
                                color: Colors.blue, // Color del enlace
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  launchUrl(Uri.parse('https://www.okylife.cl/algoritmo/'));
                                },
                            ),
                            
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        '- Consulta a un profesional de la salud antes de tomar una decisión sobre tu bienestar.',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontFamily: "Gilroy-Medium",
                          fontSize: 18,
                          color: const Color(0xFF201547),
                        ),
                      ),
                    ]
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: RoundedButton(
                      onPressed: _logout,
                      buttonText: "Cerrar sesión",
                      size: 200,
                    )
                  )




                ],
              ),
            ),
          )
        )
      ]
    );
  }
}
