import 'package:flutter/material.dart';
import 'package:frontend_oky_code/helpers/auth_manager.dart';
import 'package:frontend_oky_code/widgets/loading_button.dart';
import 'package:frontend_oky_code/pages/user/sign_in.dart';

class NewPasswordPage extends StatefulWidget {
  final String mail;
  const NewPasswordPage({super.key, required this.mail});

  @override
  _NewPasswordPageState createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  final _newPasswordController = TextEditingController();
  final _codeController = TextEditingController();
  bool _isLoading = false;
  bool _obscureText = true;

  void _return() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const SignInPage()));
  }

  void _newPassword() async {
    setState(() {
      _isLoading = true;
    });
    final newPassword = _newPasswordController.text.trim();
    final code = _codeController.text.trim();
    bool changed = await resetPassword(widget.mail, code, newPassword);
    Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const SignInPage()));
    if (changed) {
      showError("Cambiamos tu contraseña :)", context);
    } else {
      showError("No pudimos cambiar la contraseña :(", context);
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
                child: const Text("Cancelar")),
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
                "Ingresa el código de recuperación que enviamos a ${widget.mail} y tu nueva contraseña",
                style: TextStyle(
                  fontFamily: "Gilroy-Regular",
                  fontSize: screenHeight * 0.025,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                "Código de recuperación",
                style: TextStyle(
                  fontFamily: "Gilroy-Medium",
                  fontSize: screenHeight * 0.02,
                ),
              ),
            ),
            SizedBox(
              height: 40, // Ajusta la altura del SizedBox según tus necesidades
              child: TextField(
                controller: _codeController,
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
                "Nueva contraseña",
                style: TextStyle(
                  fontFamily: "Gilroy-Medium",
                  fontSize: screenHeight * 0.02,
                ),
              ),
            ),
            SizedBox(
              height: 40, // Ajusta la altura del SizedBox según tus necesidades
              child: TextField(
                obscureText: _obscureText,
                controller: _newPasswordController,
                style: const TextStyle(
                  fontFamily: "Gilroy-Medium",
                  fontSize: 16,
                  color: Color(0xFF201547),
                ),
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.only(bottom: 16.0, left: 10, right: 10),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                  padding: EdgeInsets.only(top: screenHeight * 0.06),
                  child: LoadingButton(
                      buttonText: "restablecer",
                      onPressed: () {
                        _newPassword();
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
