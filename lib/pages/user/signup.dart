import 'package:flutter/material.dart';
import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend_oky_code/pages/user/mail_confirmation.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController(); // Email controller for Cognito sign-up

  final userPool = CognitoUserPool(
    dotenv.env['COGNITO_USER_POOL_ID']??'',
    dotenv.env['COGNITO_CLIENT_ID']??'',
  );

  void _signUp() async {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();
    final email = _emailController.text.trim(); // Ensure you collect email for Cognito sign-up

    try {
      final signUpResult = await userPool.signUp(
        username,
        password,
        userAttributes: [AttributeArg(name: 'email', value: email)], // Add other attributes as needed
      );

      if (signUpResult != null) {
        print('Sign-up successful, confirm user...');
        // Navigate to a confirmation screen or another part of your app
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => MailConfirmationPage(mail: email, username: username)));
      }
    } on CognitoClientException catch (e) {
      print('Cognito sign-up error: ${e.message}');
      // Handle Cognito-specific errors, such as user already exists
    } catch (e) {
      print('General sign-up error: $e');
      // Handle other errors, such as network errors
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
              "Bienvenido",
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
                "Registrate",
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
                obscureText: false,
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
            ),Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                "Email",
                style: TextStyle(
                  fontFamily: "Gilroy-Medium",
                  fontSize: screenHeight * 0.02,
                ),
              ),
            ),
            SizedBox(
              height: 40, // Ajusta la altura del SizedBox según tus necesidades
              child: TextField(
                obscureText: false,
                controller: _emailController,
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
                    Padding(
                      padding: EdgeInsets.only(top: screenHeight * 0.04),
                      child: InkWell(
                        onTap: () {
                          _signUp();
                        },
                        child: Image.asset(
                          "lib/assets/botones/registrate.png",
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

}
