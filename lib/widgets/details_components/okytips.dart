import 'package:flutter/material.dart';
import 'dart:math';

class OkyTips extends StatefulWidget {
  final dynamic product;
  const OkyTips({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  _OkyTipsState createState() => _OkyTipsState();
}

class _OkyTipsState extends State<OkyTips> {
  late String okyTip = "";
  late String nutricionista = "";
  late String sabiasQue = "";

  @override
  void initState() {
    super.initState();
    _getOkyTip();
  }

  void _getOkyTip() {
    if (widget.product != null) {
      if (widget.product.containsKey("oky_tips") &&
          widget.product["oky_tips"].isNotEmpty) {
        List tips = widget.product["oky_tips"];
        Random random = Random();
        int randomIndex = random.nextInt(tips.length);
        okyTip = tips[randomIndex]["oky_tip"] ?? "Ocurrió un problema inesperado";
        nutricionista = 'Nutri ${tips[randomIndex]["nutritionist_name"] ?? "undefined"}';
      } else {
        okyTip = "No tenemos OkyTips para este producto aún :(";
      }

      if (widget.product.containsKey("sabias_que")) {
        sabiasQue = widget.product["sabias_que"];
      } else {
        sabiasQue = "No tenemos información de este producto aún :(";
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double margins = 0.04;
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      color: const Color(0xFFE8E4F4),
      margin: EdgeInsets.symmetric(horizontal: screenWidth * margins),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 2),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: screenWidth * 0.8,
                  padding: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(
                      color: const Color(0xFF7448ED),
                      width: 2.0, 
                    )
                
                  ),
                  child: Column(
                    children: [
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: 'OkyTip: ',
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: "Gilroy-Bold",
                                color: Color(0xFF7448ED),
                              ),
                            ),
                            TextSpan(
                              text: okyTip,
                              style: const TextStyle(
                                fontSize: 18,
                                fontFamily: "Gilroy-Medium",
                                color: Color(0xFF201547),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          nutricionista,
                          style: const TextStyle(
                            fontSize: 16,
                            fontFamily: "Gilroy-Normal",
                            color: Color(0xFF7448ED),
                          ),
                        ),
                      ),
                    ],
                  )
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Transform.translate(
                    offset: const Offset(-40, -2),
                    child: TriangleWidget()
                  )
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround, 
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: screenWidth * 0.5,
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(
                          color: const Color(0xFF7448ED),
                          width: 2.0, 
                        )
                      ),
                      child: Column(
                        children: [
                          const Text(
                            "¿Sabías que?...",
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: "Gilroy-Bold",
                              color: Color(0xFF7448ED),
                            ),
                          ),
                          Text(
                            sabiasQue,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              fontFamily: "Gilroy-Medium",
                              color: Color(0xFF201547),
                            ),
                          ),
                        ],
                      )
                    ),
                    Image.asset(
                      'lib/assets/nutria_recortada.png',
                      height: screenWidth * 0.8,
                    ),
                  ]
                )
              ]
            ),
          )
        ],
      )
    );
  }
}

class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paintFill = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final paintBorder = Paint()
      ..color = const Color(0xFF7448ED) // Cambia este color al que desees para los bordes
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0; // Cambia este valor al grosor del borde deseado

    final path = Path();
    path.moveTo(0, 0); // Mueve el lápiz al punto superior izquierdo
    path.lineTo(size.width, 0); // Dibuja una línea al punto superior derecho
    path.lineTo(size.width / 2, size.height); // Dibuja una línea al punto inferior central
    path.close(); // Cierra el camino para formar un triángulo

    // Dibuja el relleno del triángulo
    canvas.drawPath(path, paintFill);

    // Dibuja los bordes inferiores
    final borderPath = Path();
    borderPath.moveTo(0, 0);
    borderPath.lineTo(size.width / 2, size.height);
    borderPath.lineTo(size.width, 0);

    canvas.drawPath(borderPath, paintBorder);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class TriangleWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(35, 35), // Tamaño del triángulo invertido
      painter: TrianglePainter(),
    );
  }
}
