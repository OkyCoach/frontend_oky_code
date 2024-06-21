import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:frontend_oky_code/main.dart';

class PermissionDialogWidget extends StatelessWidget {

  const PermissionDialogWidget({Key? key}) : super(key: key);

  void _returnToHome(context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const MainPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0); // starting offset from right
          const end = Offset.zero;
          const curve = Curves.easeInOutQuart;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          var offsetAnimation = animation.drive(tween);

          return SlideTransition(position: offsetAnimation, child: child);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Permiso de micrófono y cámara requerido.",
        style: TextStyle(
          fontFamily: "Gilroy-SemiBold",
          fontSize: 25,
          color: const Color(0xFF7448ED),
        ),
        textAlign: TextAlign.center,
      ),
      content: const Text(
        "Por favor autoriza el acceso al micrófono y cámara en los ajustes.",
        style: TextStyle(
          fontFamily: "Gilroy-Medium",
          fontSize: 18,
        ),
        textAlign: TextAlign.center,
      ),
      actions: [
        TextButton(
          child: const Text(
            "No gracias",
            style: TextStyle(
              fontFamily: "Gilroy-Semibold",
              fontSize: 18,
              color: Color(0xFF7448ED),
            ),
          ),
          onPressed: () {
            _returnToHome(context);
          },
        ),
        TextButton(
          child: const Text(
            "Ajustes",
            style: TextStyle(
              fontFamily: "Gilroy-Semibold",
              fontSize: 18,
              color: Color(0xFF7448ED),
            ),
          ),
          onPressed: () {
            openAppSettings();
            Navigator.pop(context);
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
