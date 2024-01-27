import 'package:flutter/material.dart';
import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:frontend_oky_code/pages/sign_up_test.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
            Text(
                userSession.toString()), // Muestra los atributos del usuario
          ],
        ),
      ),
    );
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
