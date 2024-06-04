import 'package:flutter/material.dart';
import 'package:frontend_oky_code/main.dart';
import 'package:frontend_oky_code/helpers/auth_manager.dart';
import 'package:frontend_oky_code/pages/user/sign_up.dart';
import 'package:frontend_oky_code/widgets/loading_button.dart';
import 'package:frontend_oky_code/pages/user/forgot_password.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscureText = true;
  bool _isLoading = false;

  void _signIn() async {
    setState(() {
      _isLoading = true;
    });
    var result = await signIn(
      _emailController.text.trim(), 
      _passwordController.text.trim()
    );
    if (result.verified) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const MainPage()));
    } else {
      showError(
        result.message, 
        context
      );
    }
    setState(() {
      _isLoading = false;
    });
  }
  void _forgotPassword(){
    Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const ForgotPasswordPage()));
  }
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
      width: screenWidth,
      height: screenHeight,
      decoration: const BoxDecoration(
        color: Color(0xFFF9F9FA),
      ),
      child: Padding(
        padding:
            EdgeInsets.only(left: 30.0, right: 30.0, top: screenHeight * 0.06),
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
              padding: EdgeInsets.only(top: screenHeight * 0.04),
              child: Text(
                "Inicia sesión",
                style: TextStyle(
                  fontFamily: "Gilroy-Medium",
                  fontSize: screenHeight * 0.033,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
            Padding(
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
                obscureText: _obscureText,
                controller: _passwordController,
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: AlignmentDirectional.topStart,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20, top: 5),
                    child: InkWell(
                      onTap: (){
                        _forgotPassword();
                      },
                      child: Text(
                        "¿Olvidaste tu contraseña?",
                        style: TextStyle(
                          fontFamily: "Gilroy-Regular",
                          fontSize: screenHeight * 0.02,
                          color: const Color(0xFF97999B),
                        ),
                      ),
                    ),
                  )
                ),
                Text(
                  "¿Aún no tienes una cuenta?",
                  style: TextStyle(
                    fontFamily: "Gilroy-Regular",
                    fontSize: screenHeight * 0.02,
                    color: const Color(0xFF97999B),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 3),
                  child: InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignUpPage())),
                    child: Text(
                      "Registrate aquí",
                      style: TextStyle(
                        fontFamily: "Gilroy-Regular",
                        fontSize: screenHeight * 0.02,
                        color: const Color(0xFF97999B),
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: screenHeight * 0.04),
                  child: LoadingButton(
                      buttonText: "inicia sesión",
                      onPressed: () {
                        _signIn();
                      },
                      size: 200,
                      isLoading: _isLoading,
                      color: 'purple',
                      enabled: true))
              ]),
          ],
        ),
      ),
    )));
  }
}
