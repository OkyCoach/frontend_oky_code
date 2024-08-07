import 'package:flutter/material.dart';
import 'package:frontend_oky_code/widgets/v2_product_detail.dart';
import 'package:frontend_oky_code/widgets/details_components/stars_widget.dart';
import 'package:frontend_oky_code/helpers/fetch_data.dart';
import 'package:frontend_oky_code/widgets/recommended.dart';

class ProductPopup extends StatefulWidget {
  final dynamic product;
  final dynamic evaluation;
  final bool scanning;
  final ValueChanged<bool> controlScan;

  ProductPopup({
    Key? key,
    required this.product,
    required this.evaluation,
    required this.scanning,
    required this.controlScan,
  }) : super(key: key);

  @override
  _ProductPopupState createState() => _ProductPopupState();
}

class _ProductPopupState extends State<ProductPopup> {
  List<dynamic> recommendedProducts = [];
  bool ready = false;
  late bool isLiked;
  late int likes;

  void _showProductDetails(context) {
    Navigator.pop(context);
    showDialog(
      barrierDismissible: false,
      barrierColor: Colors.white.withOpacity(0),
      context: context,
      builder: (BuildContext context) {
        return ProductDetailV2(
          product: widget.product,
          evaluation: widget.evaluation,
          scanning: widget.scanning,
          controlScan: widget.controlScan,
        );
      },
    );
  }

  void _toggleLike() {
    setState(() {
      likeProduct(widget.product["_id"], isLiked);
      isLiked = !isLiked;
      isLiked 
        ? likes += 1 
        : likes -= 1;
    });
  }

  @override
  void initState() {
    super.initState();
    isLiked = widget.product["liked"] ?? false;
    likes = widget.product["totalLikes"] ?? 0;
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      List<dynamic> products =
          await fetchRecommendedProducts(widget.product["barcode"]);
      setState(() {
        recommendedProducts = products;
        ready = true;
      });
    } catch (error) {
      print("Error al obtener los productos recomendados: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.only(bottom: screenHeight * 0.07),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            width: screenWidth,
            height: screenHeight * 0.6,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
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
                        widget.controlScan(false);
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Dialog(
                    insetPadding: const EdgeInsets.symmetric(vertical: 5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    elevation: 1,
                    child: IntrinsicHeight(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          bottom: 15,
                          top: 10,
                          left: 15,
                          right: 15,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
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
                                      _showProductDetails(context);
                                    },
                                    child: Image.asset(
                                      'lib/assets/botones/ver_producto.png',
                                      width: screenWidth * 0.5,
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        '$likes',
                                        style: const TextStyle(
                                          fontFamily: "Gilroy-Bold",
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
                                              height: screenHeight * 0.045,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Recommended(
            recommendedProducts: recommendedProducts,
            ready: ready,
            scanning: widget.scanning,
            controlScan: widget.controlScan,
          )
        ],
      ),
    );
  }
}
