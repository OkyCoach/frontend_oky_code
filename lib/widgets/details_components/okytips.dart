import 'package:flutter/material.dart';
import 'dart:math';
import 'package:frontend_oky_code/helpers/fetch_data.dart';
import 'package:frontend_oky_code/widgets/details_components/okytips-components/okytip.dart';
import 'package:frontend_oky_code/widgets/details_components/okytips-components/sabias-que.dart';

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
  late String okyTipId = "";
  late String sabiasQue = "";
  bool showFullText = false;
  late bool isLiked;
  late int likes;
  int? currentTipIndex;

  @override
  void initState() {
    super.initState();
    _getOkyTip();
  }

  void _getOkyTip() {
    if (widget.product != null) {
      if (widget.product.containsKey("oky_tips") &&
          widget.product["oky_tips"] != null &&
          widget.product["oky_tips"].isNotEmpty) {
        List tips = widget.product["oky_tips"];
        Random random = Random();
        int randomIndex = random.nextInt(tips.length);
        okyTip =
            tips[randomIndex]["oky_tip"] ?? "Ocurrió un problema inesperado";
        
        currentTipIndex = randomIndex;
        
        likes = tips[randomIndex]["totalLikes"] ?? 0;
        isLiked = tips[randomIndex]["liked"] ?? false;
        okyTipId = tips[randomIndex]["oky_tip_id"] ?? "";
        
        nutricionista =
            'Nutri ${tips[randomIndex]["nutritionist_name"] ?? "undefined"}';
      } else {
        likes = 0;
        isLiked = false;
        okyTipId = "";
        okyTip = "No tenemos OkyTips para este producto aún :(";
      }

      if (widget.product.containsKey("sabias_que") &&
          widget.product["sabias_que"] != null &&
          widget.product["sabias_que"].isNotEmpty) {
        List allSabiasQue = widget.product["sabias_que"];
        Random random = Random();
        int randomIndex = random.nextInt(allSabiasQue.length);
        sabiasQue = allSabiasQue[randomIndex]["message"] ??
            "Ocurrió un problema inesperado";
      } else {
        sabiasQue = "No tenemos información de este producto aún :(";
      }
    }
  }

  void _toggleLike() {
    setState(() {
      likeOkytip(widget.product["_id"], okyTipId, isLiked);
      isLiked = !isLiked;
      isLiked ? likes += 1 : likes -= 1;
      widget.product["oky_tips"][currentTipIndex!]["liked"] = isLiked;
      widget.product["oky_tips"][currentTipIndex!]["totalLikes"] = likes;
    });
  }

  @override
  Widget build(BuildContext context) {
    double margins = 0.04;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
        color: const Color(0xFFE8E4F4),
        padding: const EdgeInsets.only(top: 5, left: 15, right: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child:
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start, 
                    children: [
                      OkyTipCard(
                        okyTipId: okyTipId,
                        okyTip: okyTip,
                        nutricionista: nutricionista,
                        likes: likes,
                        isLiked: isLiked,
                        onToggleLike: _toggleLike
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Transform.translate(
                          offset: const Offset(-30, -2),
                          child: TriangleWidget()
                        )
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SabiasQueCard(sabiasQue: sabiasQue),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Image.asset(
                              'lib/assets/nutria_recortada.png',
                              height: screenWidth * 0.6,
                            ),
                          )
                        ]
                      )
              ]),
            )
          ],
        ));
  }
}

class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paintFill = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final paintBorder = Paint()
      ..color = const Color(
          0xFF7448ED) // Cambia este color al que desees para los bordes
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0; // Cambia este valor al grosor del borde deseado

    final path = Path();
    path.moveTo(0, 0); // Mueve el lápiz al punto superior izquierdo
    path.lineTo(size.width, 0); // Dibuja una línea al punto superior derecho
    path.lineTo(size.width / 2,
        size.height); // Dibuja una línea al punto inferior central
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
