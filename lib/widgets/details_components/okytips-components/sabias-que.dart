import 'package:flutter/material.dart';

class SabiasQueCard extends StatefulWidget {
  final String sabiasQue;

  const SabiasQueCard({
    Key? key,
    required this.sabiasQue,
  }) : super(key: key);

  @override
  _SabiasQueCardState createState() => _SabiasQueCardState();
}

class _SabiasQueCardState extends State<SabiasQueCard> {
  bool showFullText = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: screenWidth * 0.55,
      padding: const EdgeInsets.only(left: 10.0, right: 10, top: 15),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: const Color(0xFF7448ED),
          width: 1.0,
        ),
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
            showFullText
                ? widget.sabiasQue
                : widget.sabiasQue.length > 100
                ? '${widget.sabiasQue.substring(0, 100)}...'
                : widget.sabiasQue,
            textAlign: TextAlign.justify,
            style: TextStyle(
                fontSize: screenHeight*0.02,
              fontFamily: "Gilroy-Medium",
              color: Color(0xFF201547),
            ),
          ),
          if (widget.sabiasQue.length > 100)
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
    );
  }
}
