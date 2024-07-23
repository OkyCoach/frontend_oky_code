import 'package:flutter/material.dart';
import 'package:frontend_oky_code/pages/add_product/new_product.dart';

class NotFoundPopup extends StatelessWidget {
  final String barcode;
  final bool scanning;
  final ValueChanged<bool> controlScan;

  const NotFoundPopup({
    Key? key,
    required this.barcode,
    required this.scanning,
    required this.controlScan,
  }) : super(key: key);

  void _addProduct(BuildContext context) {
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            NewProductPage(barcode: barcode),
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

  void _notifyMissing(BuildContext context) async {
    //notifyMissingProduct(barcode);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double logoWidth = 70;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      insetPadding: const EdgeInsets.only(left: 15, right: 15),
      elevation: 1,
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
                  width: 4.0, // Ancho del borde blanco
                ),
              ),
              child: Image.asset(
                "lib/assets/logos/logo_degrade.png",
                width: logoWidth,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              "No pudimos encontrar el producto :(",
              style: TextStyle(
                  fontFamily: "Gilroy-SemiBold",
                  fontSize: screenWidth*0.07,
                  color: const Color(0xFF7448ED)),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Text(
              "¡Tus contribuciones son valiosas! Puedes agregar el producto y ayudar a otros a encontrarlo.",
              style: TextStyle(
                fontFamily: "Gilroy-Medium",
                fontSize: screenWidth*0.05,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          InkWell(
            onTap: () {
              _addProduct(context);
              controlScan(false);
            },
            child: Image.asset(
              'lib/assets/botones/oky.png', // Ruta de tu imagen
              width: screenWidth * 0.25,
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 15),
              child: InkWell(
                onTap: () {
                  controlScan(false);
                  _notifyMissing(context);
                },
                child: Text(
                  "No gracias",
                  style: TextStyle(
                      fontFamily: "Gilroy-Medium",
                      fontSize: screenWidth*0.04,
                      color: const Color(0xFF97999B)),
                ),
              )),
        ],
      ),
    );
  }
}
