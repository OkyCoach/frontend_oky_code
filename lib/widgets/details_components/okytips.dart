import 'package:flutter/material.dart';
import 'dart:math';
import 'package:frontend_oky_code/helpers/fetch_data.dart';

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
        margin: EdgeInsets.symmetric(horizontal: screenWidth * margins),
        padding: const EdgeInsets.only(top: 5, left: 15, right: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child:
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start, 
                    children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.0),
                        border: Border.all(
                          color: const Color(0xFF7448ED),
                          width: 2.0,
                        )),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [ 
                        Padding(
                          padding:  const EdgeInsets.only(bottom: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: Text(
                                  '$likes',
                                  style: const TextStyle(
                                    fontFamily: "Gilroy-Bold",
                                    ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  _toggleLike();
                                },
                                child: ClipOval(
                                  child: ColorFiltered(
                                    colorFilter: ColorFilter.mode(
                                      (isLiked)
                                          ? Colors.transparent
                                          : Color(0xFFE8E4F4),
                                      BlendMode.color,
                                    ),
                                    child: Image.asset(
                                      (isLiked)
                                          ? 'lib/assets/me_gusta.png'
                                          : 'lib/assets/no_me_gusta.png',
                                      height: screenHeight * 0.04,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ), 
                        ), 
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: 'OkyTip: ',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: "Gilroy-Bold",
                                  color: Color(0xFF7448ED),
                                ),
                              ),
                              TextSpan(
                                text: okyTip,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontFamily: "Gilroy-Medium",
                                  color: Color(0xFF201547),
                                ),
                              ),
                            ],
                          ),
                        ),
                        if(okyTipId != "")
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 5),
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
                    )),
                Align(
                    alignment: Alignment.bottomRight,
                    child: Transform.translate(
                        offset: const Offset(-30, -2),
                        child: TriangleWidget())),
                const SizedBox(height: 20),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: screenWidth * 0.55,
                        padding: const EdgeInsets.all(8.0),
                        margin: const EdgeInsets.only(bottom: 5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.0),
                            border: Border.all(
                              color: const Color(0xFF7448ED),
                              width: 2.0,
                            )),
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
                              showFullText
                                  ? sabiasQue
                                  : sabiasQue.length > 100
                                      ? '${sabiasQue.substring(0, 100)}...'
                                      : sabiasQue,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 16,
                                fontFamily: "Gilroy-Medium",
                                color: Color(0xFF201547),
                              ),
                            ),
                            if (sabiasQue.length > 100)
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    showFullText = !showFullText;
                                  });
                                },
                                child: Text(
                                  showFullText ? "Ver menos" : "Ver más",
                                  style: const TextStyle(
                                    color: Color(0xFF7448ED),
                                    fontFamily: "Gilroy-Bold",
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Image.asset(
                          'lib/assets/nutria_2_sin_cola.png',
                          height: screenWidth * 0.8,
                        ),
                      )
                    ])
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
      ..strokeWidth = 2.0; // Cambia este valor al grosor del borde deseado

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
