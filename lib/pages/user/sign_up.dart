import 'package:flutter/material.dart';
import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend_oky_code/pages/user/sign_in.dart';
import 'package:frontend_oky_code/pages/user/mail_confirmation.dart';
import 'package:frontend_oky_code/helpers/auth_manager.dart';
import 'package:frontend_oky_code/widgets/loading_button.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _nameController = TextEditingController();
  final _familyNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _referredCodeController = TextEditingController();

  bool _obscureText = true;

  bool _hasUppercase = false;
  bool _hasDigit = false;
  bool _minimumCharacters = false;
  bool _enabledButton = false;
  bool _isLoading = false;

  void _signUp() async {
    setState(() {
      _isLoading = true;
    });
    final name = _nameController.text.trim();
    final familyName = _familyNameController.text.trim();
    final password = _passwordController.text.trim();
    final email = _emailController.text.trim();
    final referredCode = _referredCodeController.text.trim();

    try {
      final signUpResult = await userPool.signUp(
        email,
        password,
        userAttributes: [
          AttributeArg(name: 'name', value: name),
          AttributeArg(name: 'family_name', value: familyName),
          AttributeArg(name: 'custom:referrer_code', value: referredCode),
          AttributeArg(name: 'custom:platform', value: "app"),
        ],
      );

      if (signUpResult != null) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => MailConfirmationPage(
              mail: email,
              password: password,
              referredCode: referredCode,
              )));
      }
    } on CognitoClientException catch (e) {
      showError(
        e.message,
        context
      );
    } catch (e) {
      showError(
        "Unexpected error, try again later.",
        context
      );
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _updatePasswordStatus() {
    setState(() {
      _minimumCharacters = _passwordController.text.trim().length >= 8;
      _hasUppercase =
          _passwordController.text.trim().contains(RegExp(r'[A-Z]'));
      _hasDigit = _passwordController.text.trim().contains(RegExp(r'[0-9]'));
      _enabledButton = _minimumCharacters && _hasUppercase && _hasDigit;
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
              padding: EdgeInsets.only(top: screenHeight * 0.04),
              child: Text(
                "Registrate",
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
                "Nombre",
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
                controller: _nameController,
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
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                "Apellido",
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
                controller: _familyNameController,
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
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                "Código de referido (opcional)",
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
                controller: _referredCodeController,
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
              padding: const EdgeInsets.only(top: 10),
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
                onChanged: (value) => _updatePasswordStatus(),
                obscureText: _obscureText,
                controller: _passwordController,
                style: const TextStyle(
                  fontFamily: "Gilroy-Medium",
                  fontSize: 16,
                  color: Color(0xFF201547),
                ),
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.only(bottom: 16.0, left: 10, right: 10),
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
            Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _minimumCharacters
                                  ? Colors.green
                                  : Colors.grey
                              // Puedes cambiar el color según tus preferencias
                              ),
                        ),
                        const SizedBox(width: 5),
                        const Text(
                          "Más de 7 caracteres.",
                          style: TextStyle(
                            fontFamily: "Gilroy-Medium",
                            fontSize: 11,
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _hasUppercase
                                  ? Colors.green
                                  : Colors
                                      .grey // Puedes cambiar el color según tus preferencias
                              ),
                        ),
                        const SizedBox(width: 5),
                        const Text(
                          "Contiene mayúsculas.",
                          style: TextStyle(
                            fontFamily: "Gilroy-Medium",
                            fontSize: 11,
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _hasDigit
                                  ? Colors.green
                                  : Colors
                                      .grey // Puedes cambiar el color según tus preferencias
                              ),
                        ),
                        const SizedBox(width: 5),
                        const Text(
                          "Contiene números.",
                          style: TextStyle(
                            fontFamily: "Gilroy-Medium",
                            fontSize: 11,
                          ),
                        )
                      ],
                    ),
                  ],
                )),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Align(
                  alignment: Alignment.center,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "¿Ya tienes una cuenta?",
                          style: TextStyle(
                            fontFamily: "Gilroy-Regular",
                            fontSize: screenHeight * 0.018,
                            color: const Color(0xFF97999B),
                          ),
                        ),
                        //enlace a la página de registro
                        InkWell(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignInPage())),
                          child: Text(
                            "Inicia sesión",
                            style: TextStyle(
                              fontFamily: "Gilroy-Regular",
                              fontSize: screenHeight * 0.018,
                              color: const Color(0xFF97999B),
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),

                        Padding(
                            padding: EdgeInsets.only(top: screenHeight * 0.038),
                            child: LoadingButton(
                                buttonText: "regístrate",
                                onPressed: () {
                                  _enabledButton ? _signUp() : null;
                                },
                                size: 200,
                                isLoading: _isLoading,
                                color: 'purple',
                                enabled: _enabledButton,
                                )
                              )
                      ])),
            )
          ],
        ),
      ),
    )));
  }
}
