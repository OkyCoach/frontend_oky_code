import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LuckyplayGiveawayPopup extends StatelessWidget {
  final String contestUrl;
  final VoidCallback onClose;

  const LuckyplayGiveawayPopup({
    required this.contestUrl,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: screenWidth*0.04),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Container(
        width: screenWidth,
        decoration: BoxDecoration(
          color: Colors.white, // Fondo blanco del popup
          borderRadius: BorderRadius.circular(25.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
          border: Border.all(
            color: Colors.grey.shade300,
            width: 1.0,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 30.0, right: 30, top: 15, bottom: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'lib/assets/logos/logo_ly.jpeg', // Asegúrate de que la ruta sea correcta
                height: screenHeight * 0.1, // Ajusta el tamaño de la imagen
              ),
              SizedBox(height: 20,),
              Text(
                '¡Participa en nuestro concurso junto a LuckyPlay!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Gilroy-Bold",
                  fontSize: screenHeight * 0.023,
                  color: Color(0xFF7448ED),
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                'Haz clic en "Participar" para unirte al concurso y tener la oportunidad de ganar premios increíbles.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Gilroy-Regular",
                  fontSize: screenHeight * 0.018,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 24.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Botón Participar con mayor ancho
                  SizedBox(
                    width: screenWidth * 0.8, // 80% del ancho de la pantalla
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF7448ED), // Color morado
                        foregroundColor: Colors.white, // Texto blanco
                        shape: StadiumBorder(),
                        minimumSize: Size(screenWidth * 0.8, 40), // Ancho y alto mínimos
                      ),
                      onPressed: () async {
                        if (await canLaunchUrl(Uri.parse(contestUrl))) {
                          await launchUrl(Uri.parse(contestUrl));
                          Navigator.of(context).pop();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('No se pudo abrir el enlace.')),
                          );
                        }
                      },
                      child: Text(
                        'Participar',
                        style: TextStyle(
                          fontFamily: "Gilroy-Bold",
                          fontSize: screenHeight * 0.023,
                          color: Colors.white,
                          height: 1.1,
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: onClose,
                    child: Text(
                      'No gracias',
                      style: TextStyle(
                        fontFamily: "Gilroy-Regular",
                        fontSize: screenHeight * 0.018,
                        height: 1.1,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
