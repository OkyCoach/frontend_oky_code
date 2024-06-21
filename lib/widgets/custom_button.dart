import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;
  final double size;

  RoundedButton({required this.onPressed, required this.buttonText, required this.size});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF7448ED), 
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(60.0), 
          
        ),
      ),
      child: SizedBox(
        height: 35.0,
        width: size, 
        child: Center(
          child: Text(
            buttonText.toUpperCase(),
            style: const TextStyle(
                letterSpacing: 1,
                fontFamily: "Gilroy-Black",
                fontSize: 18,
                color: Colors.white, 
              ),
          ),
        ),
      ),
    );
  }
}
