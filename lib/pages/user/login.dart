import 'package:flutter/material.dart';
import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:frontend_oky_code/main.dart';
import 'package:frontend_oky_code/helpers/auth_manager.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'package:frontend_oky_code/pages/user/signup.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend_oky_code/widgets/loading_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscureText = true;
  bool _isLoading = false;
  var userSession;

  void _login() async {
    setState(() {
      _isLoading = true;
    });
    var session = await login(
        _usernameController.text.trim(), _passwordController.text.trim());
    if (session != null) {
      await AuthManager().saveSession({
        'accessToken': session.accessToken.toString(),
        'refreshToken': session.refreshToken.toString(),
        'idToken': session.idToken.toString(),
        'userInfo': jsonEncode(session.idToken.payload),
      });

      final storage = FlutterSecureStorage();
      await storage.write(
          key: 'session', value: jsonEncode(session.toString()));
      
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const MainPage()));
    } else {
      // Handle login error
      // Show an error message
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
                        //enlace a la página de registro
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
                                fontSize: screenHeight * 0.018,
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
                                _login();
                              },
                              size: 200,
                              isLoading: _isLoading,
                              color: 'purple'
                            ))
                      ])),
            )
          ],
        ),
      ),
    )));
  }

  final userPool = CognitoUserPool(
    dotenv.env['COGNITO_USER_POOL_ID'] ?? '',
    dotenv.env['COGNITO_CLIENT_ID'] ?? '',
  );
  void _showError(String message) {
    // Use the scaffold key to get the context for the ScaffoldMessenger
    // and show a SnackBar.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color(0xFF7448ED),
        dismissDirection: DismissDirection.down,
        margin: const EdgeInsets.all(5),
        content: Text(
          message,
          style: const TextStyle(
              fontFamily: "Gilroy-Semibold", fontSize: 12, color: Colors.white),
        ),
      ),
    );
  }

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
        print('token id: ${userSession.refreshToken?.token}');

        return userSession;
      } else {
        print(userSession);
        return null;
      }
    } on CognitoUserException catch (e) {
      return null;
    } on CognitoClientException catch (e) {
      print(e);
      _showError('${e.message}');
      return null;
    } catch (e) {
      _showError('Ocurio un error inesperado');
      return null;
    }
  }
}
