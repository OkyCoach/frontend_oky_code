import 'package:flutter/material.dart';

class OkyTipCard extends StatelessWidget {
  final String okyTipId;
  final String okyTip;
  final String nutricionista;
  final int likes;
  final bool isLiked;
  final VoidCallback onToggleLike;

  const OkyTipCard({
    Key? key,
    required this.okyTipId,
    required this.okyTip,
    required this.nutricionista,
    required this.likes,
    required this.isLiked,
    required this.onToggleLike,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: const Color(0xFF7448ED),
          width: 2.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (okyTipId != "")
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Okytip",
                    style: TextStyle(
                      fontSize: screenHeight*0.024,
                      fontFamily: "Gilroy-SemiBold",
                      color: Color(0xFF7448ED),
                    ),
                  ),
                  Row(
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
                        onTap: onToggleLike,
                        child: ClipOval(
                          child: ColorFiltered(
                            colorFilter: ColorFilter.mode(
                              isLiked ? Colors.transparent : Color(0xFFE8E4F4),
                              BlendMode.color,
                            ),
                            child: Image.asset(
                              isLiked
                                  ? 'lib/assets/me_gusta.png'
                                  : 'lib/assets/no_me_gusta.png',
                              height: screenHeight * 0.04,
                            ),
                          ),
                        ),
                      ),
                    ]
                  )
                ],
              ),
            ),
            Text(
              okyTip,
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: screenHeight*0.02,
                fontFamily: "Gilroy-Normal",

                color: Colors.black,
              ),
            ),
            if (okyTipId != "")
              Padding(
                padding: const EdgeInsets.only(top: 10),
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
      ),
    );
  }
}
