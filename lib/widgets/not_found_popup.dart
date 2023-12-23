import 'package:flutter/material.dart';

class NotFoundPopup extends StatelessWidget {
  const NotFoundPopup({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double popupHeight = screenHeight * 0.35;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      elevation: 10,
      child: SizedBox(
        height: popupHeight,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text(
                  "No pudimos encontrar el producto :(",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF7448ED)
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Text(
                  "¡Tus contribuciones son valiosas! Puedes agregar el producto y ayudar a otros a encontrarlo.",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
              ),
              InkWell(   
                child: Image.asset(
                  "lib/assets/botones/agregar.png",
                  height:
                      popupHeight * 0.15, // Ajusta según tus necesidades,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 5),
                child: Text(
                  "No gracias",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: Color(0xFF97999B)
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
