import 'package:flutter/material.dart';
import 'package:frontend_oky_code/widgets/details_components/stars_widget.dart';
import 'package:frontend_oky_code/widgets/details_components/like-button.dart';

class ProductPopup extends StatefulWidget {
  final dynamic product;
  final dynamic evaluation;
  final ValueChanged<bool> showPopUp;
  final ValueChanged<bool> scanning;
  final ValueChanged<bool> showDetails;
  final bool isLiked;
  final int likes;
  final ValueChanged<bool> changeLike;

  ProductPopup({
    Key? key,
    required this.product,
    required this.evaluation,
    required this.showPopUp,
    required this.scanning,
    required this.showDetails,
    required this.isLiked,
    required this.likes,
    required this.changeLike,
  }) : super(key: key);

  @override
  _ProductPopupState createState() => _ProductPopupState();
}

class _ProductPopupState extends State<ProductPopup> {
  List<dynamic> recommendedProducts = [];
  bool ready = false;
  late bool isLiked;
  late int likes;

  @override
  void initState() {
    super.initState();
    isLiked = widget.product["liked"] ?? false;
    likes = widget.product["totalLikes"] ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children:[
        Container(
          width: 35.0,
          height: 35.0,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: IconButton(
            icon: const Icon(
              Icons.clear,
              size: 20.0,
              color: Color(0xFF7448ED),
            ),
            onPressed: () {
              widget.showPopUp(false);
              widget.scanning(true);
            },
          ),
        ),
        Container(
          width: screenWidth * 0.95,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  widget.product["photoUrl"] != null
                      ? Image.network(
                    widget.product["photoUrl"],
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
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Column(
                        mainAxisAlignment:
                        MainAxisAlignment.start,
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.product["name"] ?? 'not_found',
                            style: TextStyle(
                              fontFamily: "Gilroy-SemiBold",
                              fontSize: screenHeight * 0.025,
                              color: const Color(0xFF7448ED),
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          Text(
                            (widget.product?["brands"]
                                ?.isNotEmpty ??
                                false)
                                ? widget.product["brands"][0]
                            ["name"] ??
                                'not_found'
                                : 'not_found',
                            style: TextStyle(
                              fontFamily: "Gilroy-Medium",
                              fontSize: screenHeight * 0.025,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.only(top: 8),
                            child: StarsWidget(
                              maxScore: widget
                                  .evaluation["puntos_totales"],
                              actualScore: widget
                                  .evaluation["puntos_obtenidos"],
                              height: 0.03,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        widget.showPopUp(false);
                        widget.showDetails(true);
                      },
                      child: Image.asset(
                        'lib/assets/botones/ver_producto.png',
                        width: screenWidth * 0.5,
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          '${widget.likes}',
                          style: const TextStyle(
                            fontFamily: "Gilroy-Bold",
                          ),
                        ),
                       LikeButton(
                         isLiked: widget.isLiked,
                         changeLike: widget.changeLike,
                         productId: widget.product["_id"]
                       )
                      ],
                    ),
                  ],
                ),
              ),
            ]
          ),
        ),
      ]
    );
  }
}
