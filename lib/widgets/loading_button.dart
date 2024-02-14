import 'package:flutter/material.dart';

class LoadingButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;
  final bool isLoading;
  final double size;

  LoadingButton({
    required this.onPressed,
    required this.buttonText,
    required this.isLoading,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isLoading ? 0.7 : 1.0, // Cambia la opacidad si está cargando
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF7448ED), // Color de fondo morado
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(60.0), // Bordes redondeados
          ),
        ),
        child: SizedBox(
          height: 40.0,
          width: size,
          child: Center(
            child: isLoading
                ? const SizedBox(
                    height: 25.0, // Ajusta el tamaño del CircularProgressIndicator
                    width: 25.0, // Ajusta el tamaño del CircularProgressIndicator
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 3.0, // Ajusta el ancho de la línea
                    ),
                  )
                : Text(
                    buttonText.toUpperCase(),
                    style: const TextStyle(
                      letterSpacing: 1,
                      fontFamily: "Gilroy-Black",
                      fontSize: 22,
                      color: Colors.white, // Color de letras blanco
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
