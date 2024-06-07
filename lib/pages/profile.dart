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
    // Initialize the future for user data
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
    return Scaffold(
      body: Container(
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
        child: FutureBuilder<Map<String, String>>(
          future: _userDataFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Show a loading indicator while waiting for the data
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              // If we run into an error, display it to the user
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              // When we have the data, display it
              final userData = snapshot.data!;
              if (userData.containsKey('userInfo') &&
                  userData['userInfo'] != null) {
                Map<String, dynamic> userInfo =
                    json.decode(userData['userInfo']!);

                return Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Image.asset(
                            'lib/assets/logos/full_logo.png',
                            width: 200,
                          )
                        ),
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
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white), // Añade un borde blanco
                            borderRadius: BorderRadius.circular(10), // Opcional: Añade bordes redondeados
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
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                        ]
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: RoundedButton(
                            onPressed: _logout,
                            buttonText: "Cerrar sesión",
                            size: 200,
                          )
                        )
                        
                      ],
                    ));
              } else {
                return const Center(
                  child: Text(
                    'No se ha iniciado sesión.',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                );
              }
            } else {

              return const Center(child: Text('No user data found.'));
            }
          },
        ),
      ),
    );
  }
}
