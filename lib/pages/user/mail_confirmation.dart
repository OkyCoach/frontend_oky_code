import 'package:flutter/material.dart';
import 'package:amazon_cognito_identity_dart_2/cognito.dart';

class MailConfirmationPage extends StatefulWidget {
  final String mail;
  const MailConfirmationPage({super.key, required this.mail});

  @override
  _MailConfirmationPageState createState() => _MailConfirmationPageState();
}

class _MailConfirmationPageState extends State<MailConfirmationPage> {
  final _codeController = TextEditingController();

  void _verify() async {}
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
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.06),
              child: Text(
                "Confirma tu email",
                style: TextStyle(
                  fontFamily: "Gilroy-Semibold",
                  fontSize: screenHeight * 0.035,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: screenHeight * 0.02, bottom: screenHeight * 0.04),
              child: Text(
                "Te hemos enviado un código de 6 dígitos a ${widget.mail}. Ingresa ese código aquí.",
                style: TextStyle(
                  fontFamily: "Gilroy-Regular",
                  fontSize: screenHeight * 0.025,
                ),
              ),
            ),
            SizedBox(
              height: 40, // Ajusta la altura del SizedBox según tus necesidades
              child: TextField(
                controller: _codeController,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Gilroy-Medium",
                  fontSize: screenHeight * 0.035,
                  color: Color(0xFF201547),
                ),
                decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.only(bottom: 16.0, left: 10, right: 10),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.06),
                child: Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () {
                      _verify;
                    },
                    child: Image.asset(
                      "lib/assets/botones/siguiente.png",
                      height: screenHeight * 0.05,
                    ),
                  ),
                )),
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
