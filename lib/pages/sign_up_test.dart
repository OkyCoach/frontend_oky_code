import 'package:flutter/material.dart';
import 'package:amazon_cognito_identity_dart_2/cognito.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();

  final userPool = CognitoUserPool(
    'us-east-1_7LsYT4REs', // Reemplaza con tu Pool ID de Cognito
    '5qad0ct7kdk6t0trn71ik12rpa', // Reemplaza con tu Client ID de Cognito
  );

  void _signUp() async {
    final userAttributes = [
      AttributeArg(name: 'email', value: _emailController.text),
      // Puedes añadir más atributos aquí si tu User Pool los requiere
    ];

    try {
      var result = await userPool.signUp(
        _usernameController.text,
        _passwordController.text,
        userAttributes: userAttributes,
      );
      if (result != null) {
        // Registro exitoso
        // Navegar a la pantalla de verificación o inicio de sesión
      } else {
        // Mostrar error de registro
      }
    } on CognitoClientException catch (e) {
      // Manejo de errores específicos de Cognito
      print(e.message);
    } catch (e) {
      // Otros errores
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
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
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            ElevatedButton(
              onPressed: _signUp,
              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
