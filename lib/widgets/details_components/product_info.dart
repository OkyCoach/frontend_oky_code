import 'package:flutter/material.dart';
import 'package:frontend_oky_code/widgets/details_components/stars_widget.dart';
import 'package:frontend_oky_code/widgets/details_components/like-button.dart';

class ProductInfoRow extends StatelessWidget {
  final dynamic product;
  final dynamic evaluation;
  final bool isLiked;
  final ValueChanged<bool> changeLike;

  const ProductInfoRow({
    Key? key,
    required this.product,
    required this.evaluation,
    required this.isLiked,
    required this.changeLike,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.only(top: 5.0, bottom: 10, left: 15, right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          product["photoUrl"] != null
            ? Image.network(
                product["photoUrl"],
                height: screenHeight * 0.15,
                width: screenHeight * 0.15,
                errorBuilder: (BuildContext context,
                    Object error,
                    StackTrace? stackTrace) {
                  return Image.asset(
                    'lib/assets/image_not_found.png',
                    height: screenHeight * 0.1,
                    width: screenHeight * 0.1,
                  );
                },
              )
            : Image.asset(
                'lib/assets/image_not_found.png',
                height: screenHeight * 0.1,
                width: screenHeight * 0.1,
              ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product["name"] ?? 'not_found',
                    style: TextStyle(
                      fontFamily: "Gilroy-Bold",
                      fontSize: screenHeight * 0.022,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  Text(
                    (product?["brands"]?.isNotEmpty ?? false)
                      ? product["brands"][0]
                              ["name"] ??
                          'not_found'
                      : 'not_found',
                    style: TextStyle(
                      fontFamily: "Gilroy-Medium",
                      fontSize: screenHeight * 0.022,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      StarsWidget(
                        maxScore: evaluation["puntos_totales"],
                        actualScore: evaluation["puntos_obtenidos"],
                        height: 0.03,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          LikeButton(
            isLiked: isLiked,
            changeLike: changeLike,
            productId: product["_id"]
          )
        ],
      ),
    );
  }
}
