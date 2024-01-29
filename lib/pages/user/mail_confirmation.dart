import 'package:flutter/material.dart';
import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:frontend_oky_code/pages/user/login.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MailConfirmationPage extends StatefulWidget {
  final String mail;
  final String username;
  const MailConfirmationPage({super.key, required this.mail, required this.username});

  @override
  _MailConfirmationPageState createState() => _MailConfirmationPageState();
}

class _MailConfirmationPageState extends State<MailConfirmationPage> {
  final _codeController = TextEditingController();

  void _verify() async {
    final code = _codeController.text.trim();
    final userPool = CognitoUserPool(
      dotenv.env['COGNITO_USER_POOL_ID']??'',
      dotenv.env['COGNITO_CLIENT_ID']??'',
    );


    final cognitoUser = CognitoUser('caduto', userPool);
    try {
      print(cognitoUser.username);
      print(code);
      final confirmationResult = await cognitoUser.confirmRegistration(code);
      if (confirmationResult) {
        // The email was successfully confirmed
        print('Email confirmed successfully.');
        // Navigate to the sign-in page or home page as appropriate

        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => LoginPage()));
      } else {
        // Handle the case where confirmation did not succeed
        print('Failed to confirm email.');
      }
    } on CognitoUserException catch (e) {
      // Handle Cognito-specific exceptions
      print('Cognito user error: ${e.message}');
    } catch (e) {
      // Handle generic exceptions
      print('Error confirming email: $e');
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
                    onTap: () => _verify(),
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

}
