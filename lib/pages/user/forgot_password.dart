import 'package:flutter/material.dart';
import 'package:frontend_oky_code/helpers/auth_manager.dart';
import 'package:frontend_oky_code/widgets/loading_button.dart';
import 'package:frontend_oky_code/pages/user/sign_in.dart';
import 'package:frontend_oky_code/pages/user/new_password.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({
    super.key,
  });

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();
  bool _isLoading = false;

  void _return() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const SignInPage()));
  }

  void _forgotPassword() async {
    setState(() {
      _isLoading = true;
    });
    final email = _emailController.text.trim();
    var requested = await forgotPassword(email);
    if (requested) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => NewPasswordPage(mail: email)));
    } else {
      showError("Unexpected error ocurred.", context);
    }
    setState(() {
      _isLoading = false;
    });
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
            ElevatedButton(
                onPressed: () {
                  _return();
                },
                child: const Text("Volver")),
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.06),
              child: Text(
                "Restablecer contraseña",
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
                "Ingresa tu correo y te enviaremos un código de recuperación.",
                style: TextStyle(
                  fontFamily: "Gilroy-Regular",
                  fontSize: screenHeight * 0.025,
                ),
              ),
            ),
            SizedBox(
              height: 40, // Ajusta la altura del SizedBox según tus necesidades
              child: TextField(
                controller: _emailController,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Gilroy-Medium",
                  fontSize: screenHeight * 0.022,
                  color: Color(0xFF201547),
                ),
                decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.only(bottom: 16.0, left: 10, right: 10),
                ),
              ),
            ),
            Center(
              child: Padding(
                  padding: EdgeInsets.only(top: screenHeight * 0.06),
                  child: LoadingButton(
                      buttonText: "enviar",
                      onPressed: () {
                        _forgotPassword();
                      },
                      size: 200,
                      isLoading: _isLoading,
                      color: 'purple',
                      enabled: true)),
            )
          ],
        ),
      ),
    )));
  }
}
