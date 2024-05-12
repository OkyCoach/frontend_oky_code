import 'package:flutter/material.dart';

class OkyTips extends StatefulWidget {
  const OkyTips({
    Key? key,
  }) : super(key: key);

  @override
  _OkyTipsState createState() => _OkyTipsState();
}

class _OkyTipsState extends State<OkyTips> {
  @override
  Widget build(BuildContext context) {
    double margins = 0.04;
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      color: const Color(0xFFE8E4F4),
      margin: EdgeInsets.symmetric(horizontal: screenWidth * margins),
      padding: const EdgeInsets.all(8),
      child: Expanded(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: screenWidth * 0.8,
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0), 
            ),
            child: const Column(
              children: [
                Text(
                  "Son bajos en calorías y ricos en fibra y nutrientes.",
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: "Gilroy-Medium",
                    color: Color(0xFF201547),
                  ),
                  textAlign: TextAlign.center,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    "Nutri Romina",
                    style: TextStyle(
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
            child:Padding(
              padding: const EdgeInsets.only(right: 40),
              child: TriangleWidget()
            )
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround, 
            children: [
              Container(
                width: screenWidth * 0.5,
                padding: const EdgeInsets.all(8.0), // Establece un relleno de 5 píxeles alrededor del contenido
                decoration: BoxDecoration(
                  color: Colors.white, 
                  borderRadius: BorderRadius.circular(20.0), 
                ),
                child: const Column(
                  children: [
                    Text(
                      "Sabías que...",
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: "Gilroy-Bold",
                        color: Color(0xFF7448ED),
                      ),
                    ),
                    Text(
                      "Están hechos generalmente de puré de manzana y arándanos, a veces mezclados con otros ingredientes como cereales, semillas o frutos secos.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: "Gilroy-Medium",
                        color: Color(0xFF201547),
                      ),
                    ),
                  ],
                )
              ),
              
              Image.asset(
                'lib/assets/nutria_2_sin_cola.png',
                height: screenWidth * 0.6,
              ),
            ]
          )
        ],
      )),
    );
  }
}

class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, 0); // Mueve el lápiz al punto superior izquierdo
    path.lineTo(size.width, 0); // Dibuja una línea al punto superior derecho
    path.lineTo(size.width / 2, size.height); // Dibuja una línea al punto inferior central
    path.close(); // Cierra el camino para formar un triángulo invertido

    canvas.drawPath(path, paint);
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
      size: Size(35, 35), // Tamaño del triángulo invertido
      painter: TrianglePainter(),
    );
  }
}
