import 'package:flutter/material.dart';
import 'package:frontend_oky_code/pages/add_product/new_product.dart';
import 'package:frontend_oky_code/helpers/fetch_data.dart';

class NotFoundPopup extends StatelessWidget {
  final String? barcode;
  const NotFoundPopup({
    Key? key,
    required this.barcode,
  }) : super(key: key);

  void _addProduct(BuildContext context) {
    //Navigator.pop(context);
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
    double popupHeight = 360;

    double logoWidth = 70;

    return Stack(
      alignment: AlignmentDirectional.centerStart,
      children: [
        Dialog(
          alignment: AlignmentDirectional.topStart,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          insetPadding: EdgeInsets.only(
              top: (screenHeight - popupHeight) / 2, left: 15, right: 15),
          elevation: 1,
          child: SizedBox(
            height: popupHeight,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10, top: 20),
                    child: Text(
                      "No pudimos encontrar el producto :(",
                      style: TextStyle(
                          fontFamily: "Gilroy-SemiBold",
                          fontSize: popupHeight * 0.08,
                          color: const Color(0xFF7448ED)),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Text(
                      "¡Tus contribuciones son valiosas! Puedes agregar el producto y ayudar a otros a encontrarlo.",
                      style: TextStyle(
                        fontFamily: "Gilroy-Medium",
                        fontSize: popupHeight * 0.06,
                      ),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      _addProduct(context);
                    },
                    child: Image.asset(
                      'lib/assets/botones/oky.png', // Ruta de tu imagen
                      width: screenWidth * 0.25,
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: InkWell(
                        onTap: () {
                          _notifyMissing(context);
                        },
                        child: Text(
                          "No gracias",
                          style: TextStyle(
                              fontFamily: "Gilroy-Medium",
                              fontSize: popupHeight * 0.045,
                              color: const Color(0xFF97999B)),
                        ),
                      )),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          left: (screenWidth - logoWidth) / 2,
          top: (screenHeight - popupHeight - logoWidth) / 2,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                  logoWidth), // Para hacer un borde circular si es necesario
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
      ],
    );
  }
}
