import 'package:flutter/material.dart';
import 'package:frontend_oky_code/helpers/auth_manager.dart';
import 'dart:convert';
import 'package:frontend_oky_code/main.dart';
import 'package:frontend_oky_code/pages/user/sign_up.dart';
import 'package:frontend_oky_code/widgets/custom_button.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:posthog_flutter/posthog_flutter.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfileState();
}

class _ProfileState extends State<ProfilePage> {
  Map<String, dynamic> _userData = {};
  bool logged = false;

  @override
  void initState() {
    super.initState();
    _getSession();
  }

  void _getSession() async {
    try {
      var data = await AuthManager().getSession();
      if (data.containsKey('userInfo') && data['userInfo'] != null) {
        Map<String, dynamic> userInfo = json.decode(data['userInfo']!);
        setState(() {
          _userData = userInfo;
          logged = true;
        });
      } else {
        setState(() {
          _userData = {"message": "No se encontro usuario"};
        });
      }
    } catch (e) {
      setState(() {
        _userData = {"message": "No se encontro usuario"};
      });
    }
  }

  void _logout() async {
    // Perform logout logic
    await AuthManager().clearSession();
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => MyApp(isFirstTime: false, isLogged: false)));
  }

  void _signUp() async {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const SignUpPage()));
  }
  void _trackScreenView() async {
    await Posthog().screen(
      screenName: 'ProfilePage',
    );
  }

  @override
  Widget build(BuildContext context) {
    _trackScreenView();
    double screenWidth = MediaQuery.of(context).size.width;
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      Expanded(
          child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Container(
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
          padding: const EdgeInsets.all(20.0),
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
              if(logged)
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: Colors.white), // Añade un borde blanco
                    borderRadius: BorderRadius.circular(
                        10), // Opcional: Añade bordes redondeados
                    color: const Color(0xFF7448ED), // Fondo transparente
                  ),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${_userData['name']} ${_userData['family_name']}',
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        _userData['email'],
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              if(!logged)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      '¿Te gusta la aplicación?',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                        child: RoundedButton(
                      onPressed: _signUp,
                      buttonText: "Registrate",
                      size: 200,
                    ))
                  ],
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
              Column(children: [
                RichText(
                  textAlign: TextAlign.justify,
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text:
                            "- Si deseas saber como respaldamos nuestra evaluacion, te invitamos a ver nuestro ",
                        style: TextStyle(
                          fontFamily: "Gilroy-Medium",
                          fontSize: 18,
                          color: Colors.white,
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
                            launchUrl(
                                Uri.parse('https://www.okylife.cl/algoritmo/'));
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
                    color: Colors.white,
                  ),
                ),
              ]),
              const SizedBox(
                height: 40,
              ),
              if (logged)
                Center(
                    child: RoundedButton(
                  onPressed: _logout,
                  buttonText: "Cerrar sesión",
                  size: 200,
                ))
            ],
          ),
        ),
      ))
    ]);
  }
}
