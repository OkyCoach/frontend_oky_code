import 'package:flutter/material.dart';

class BadConnectionPopup extends StatelessWidget {
  final bool scanning;
  final ValueChanged<bool> showBadConnection;

  const BadConnectionPopup({
    Key? key,
    required this.scanning,
    required this.showBadConnection,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double logoWidth = 70;

    return Container(
      width: screenWidth * 0.95,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Transform.translate(
            offset: Offset(0, -logoWidth/2),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                    logoWidth),
                color: Colors.white,
                border: Border.all(
                  color: Colors.white,
                  width: 4.0,
                ),
              ),
              child: Image.asset(
                "lib/assets/logos/logo_degrade.png",
                width: logoWidth,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
            child: Text(
              "Mala conexión a internet :(",
              style: TextStyle(
                  fontFamily: "Gilroy-SemiBold",
                  fontSize: screenWidth * 0.07,
                  color: const Color(0xFF7448ED)),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
            child: Text(
              "Comprueba tu conexión a internet antes de escanear otros productos.",
              style: TextStyle(
                fontFamily: "Gilroy-Medium",
                fontSize: screenWidth * 0.05,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 15),
            child: InkWell(
              onTap: () {
                showBadConnection(false);
              },
              child: Image.asset(
                'lib/assets/botones/oky.png',
                width: screenWidth * 0.25,
              ),
            ),
          )
        ],
      ),
    );
  }
}
