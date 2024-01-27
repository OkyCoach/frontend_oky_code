import 'package:flutter/material.dart';
import 'package:amazon_cognito_identity_dart_2/cognito.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  var userSession;

  void _login() async {
    var session =
        await login(_usernameController.text, _passwordController.text);
    print(session);
    if (session != null) {
      // Navegar a la siguiente pantalla o manejar la sesión de usuario
      userSession = session.accessToken.jwtToken;

      // refresh the UI
      setState(() {});
    } else {
      // Mostrar error de inicio de sesión
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
      width: screenWidth,
      decoration: const BoxDecoration(
        color: Color(0xFFF9F9FA),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: 30.0, vertical: screenHeight * 0.1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "¡Hola! :)",
              style: TextStyle(
                  fontFamily: "Gilroy-Black",
                  fontSize: screenHeight * 0.045,
                  color: const Color(0xFF7448ED)),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            Text(
              "Bienvenid@",
              style: TextStyle(
                  fontFamily: "Gilroy-Medium",
                  fontSize: screenHeight * 0.038,
                  color: const Color(0xFF7448ED)),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.06),
              child: Text(
                "Inicia sesión",
                style: TextStyle(
                  fontFamily: "Gilroy-Medium",
                  fontSize: screenHeight * 0.04,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                "Nombre de usuario",
                style: TextStyle(
                  fontFamily: "Gilroy-Medium",
                  fontSize: screenHeight * 0.02,
                ),
              ),
            ),
            SizedBox(
              height: 40, // Ajusta la altura del SizedBox según tus necesidades
              child: TextField(
                obscureText: true,
                controller: _usernameController,
                style: const TextStyle(
                  fontFamily: "Gilroy-Medium",
                  fontSize: 16,
                  color: Color(0xFF201547),
                ),
                decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.only(bottom: 16.0, left: 10, right: 10),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Text(
                "Contraseña",
                style: TextStyle(
                  fontFamily: "Gilroy-Medium",
                  fontSize: screenHeight * 0.02,
                ),
              ),
            ),
            SizedBox(
              height: 40, // Ajusta la altura del SizedBox según tus necesidades
              child: TextField(
                obscureText: true,
                controller: _passwordController,
                style: const TextStyle(
                  fontFamily: "Gilroy-Medium",
                  fontSize: 16,
                  color: Color(0xFF201547),
                ),
                decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.only(bottom: 16.0, left: 10, right: 10),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.06),
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "¿Aún no tienes una cuenta?",
                      style: TextStyle(
                        fontFamily: "Gilroy-Regular",
                        fontSize: screenHeight * 0.018,
                        color: const Color(0xFF97999B),
                      ),
                    ),
                    Text(
                      "Registrate aquí",
                      style: TextStyle(
                        fontFamily: "Gilroy-Regular",
                        fontSize: screenHeight * 0.018,
                        color: const Color(0xFF97999B),
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: screenHeight * 0.04),
                      child: InkWell(
                        onTap: () {
                          _login;
                        },
                        child: Image.asset(
                          "lib/assets/botones/iniciar_sesion.png",
                          height: screenHeight * 0.05,
                        ),
                      ),
                    )
                  ]
                )
              ),
            )
          ],
        ),
      ),
    )));
  }

  final userPool = CognitoUserPool(
    'us-east-1_7LsYT4REs', // Reemplaza con tu Pool ID de Cognito
    '5qad0ct7kdk6t0trn71ik12rpa', // Reemplaza con tu Client ID de Cognito
  );

  Future<CognitoUserSession?> login(String username, String password) async {
    final cognitoUser = CognitoUser(username, userPool);
    final authDetails = AuthenticationDetails(
      username: username,
      password: password,
    );

    try {
      var userSession = await cognitoUser.authenticateUser(authDetails);

      // Si el usuario se autentica correctamente, se devuelve una sesión de usuario
      if (userSession != null) {
        print(userSession.idToken.payload);
        return userSession;
      } else {
        print(userSession);
        return null;
      }
    } on CognitoUserException catch (e) {
      print(e.message);
      return null;
    }
  }
}
