import 'package:flutter/material.dart';
import 'package:frontend_oky_code/helpers/auth_manager.dart';
import 'dart:convert';
import 'package:frontend_oky_code/main.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfileState();
}

class _ProfileState extends State<ProfilePage> {
  Future<Map<String, String>>? _userDataFuture;

  @override
  void initState() {
    super.initState();
    // Initialize the future for user data
    _userDataFuture = AuthManager().getSession();
  }
  void _logout() async {
    // Perform logout logic
    await AuthManager().clearSession();
    // Navigate to login screen
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => MyApp(isFirstTime: false, isLogged: false)));
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        width: screenWidth,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xFF201547),
              Color(0xFF7448ED),
            ],
          ),
        ),
        child: FutureBuilder<Map<String, String>>(
          future: _userDataFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Show a loading indicator while waiting for the data
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              // If we run into an error, display it to the user
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              // When we have the data, display it
              final userData = snapshot.data!;
              Map<String, dynamic> userInfo = json.decode(userData['userInfo']!); 

              

              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Nombre: ${userInfo['cognito:username']}', // Replace with actual data key
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Email: ${userInfo['email']}', // Replace with actual data key
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    TextButton(
                      onPressed: _logout,
                      child: const Text(
                        'Cerrar sesión',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              // If there is no data, prompt the user
              return const Center(child: Text('No user data found.'));
            }
          },
        ),
      ),
    );
  }
}
