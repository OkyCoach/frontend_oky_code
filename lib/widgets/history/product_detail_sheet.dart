import 'package:flutter/material.dart';
import 'package:frontend_oky_code/widgets/dismissible_bar.dart';
import 'package:frontend_oky_code/widgets/loading_block.dart';
import 'package:frontend_oky_code/helpers/fetch_data.dart';
import 'package:frontend_oky_code/widgets/details_components/stars_widget.dart';
import 'package:frontend_oky_code/widgets/details_components/product_tabs.dart';
import 'package:frontend_oky_code/widgets/details_components/product_tabs_content.dart';

class ProductDetailSheet extends StatefulWidget {
  final dynamic product;

  ProductDetailSheet({Key? key, required this.product}) : super(key: key);

  @override
  _ProductDetailSheetState createState() => _ProductDetailSheetState();
}

class _ProductDetailSheetState extends State<ProductDetailSheet>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  dynamic _evaluation = {};
  dynamic _productData = {};
  List<dynamic> _recommendedProducts = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    )..addListener(() {
      setState(() {});
    });
    _controller.forward();

    String? barcode = widget.product["barcode"];
    if (barcode != null && barcode.isNotEmpty) {

      fetchProductEvaluation(barcode);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> fetchProductEvaluation(String barcode) async {

    var productData = await fetchBarcodeData(barcode, false);
    var evaluation = await fetchEvaluationData(barcode);
    var recommendedProducts = await fetchRecommendedProducts(barcode);
    if (!mounted) return;
    setState(() {
      _productData = productData;
      _evaluation = evaluation;
      _recommendedProducts = recommendedProducts;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return DefaultTabController(
      length: 2,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: Offset(0, 1),
          end: Offset(0, 0),
        ).animate(_animation),
        child: GestureDetector(
          onVerticalDragUpdate: (details) {
            if (details.primaryDelta! > 10) {
              Navigator.pop(context);
            }
          },
          child: Container(
            width: double.infinity,
            height: screenHeight * 0.85,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(16.0),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(top: 10),
              child: Column(
                children: [
                  const DismissibleBar(width: 40),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        widget.product["photoUrl"] != null
                            ? Image.network(
                          widget.product["photoUrl"],
                          height: screenHeight * 0.1,
                          width: screenHeight * 0.1,
                          errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
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
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.product["name"] ?? 'not_found',
                                style: TextStyle(
                                  fontFamily: "Gilroy-SemiBold",
                                  fontSize: screenHeight * 0.025,
                                  color: const Color(0xFF7448ED),
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              Text(
                                widget.product["brand"] ?? 'not_found',
                                style: TextStyle(
                                  fontFamily: "Gilroy-Medium",
                                  fontSize: screenHeight * 0.02,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              Row(
                                children: [
                                  if (isLoading)
                                    LoadingBlock(width: screenWidth * 0.35, height: 25)
                                  else if(_evaluation["puntos_totales"] != null)
                                    StarsWidget(
                                      maxScore: _evaluation["puntos_totales"],
                                      actualScore: _evaluation["puntos_obtenidos"],
                                      height: 0.03,
                                    )
                                    else if (!isLoading)
                                      Text(
                                      "Sin evaluación",
                                      style: TextStyle(
                                        fontSize: screenHeight * 0.015,
                                        fontFamily: "Gilroy-Medium",
                                        color: Color(0xFF201547),
                                      ),
                                    ),
                                    if (!isLoading) SizedBox(width: 10),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const ProductTabs(),
                  isLoading
                    ? Expanded(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : Expanded(
                        child:
                          ProductTabsContent(
                            product: _productData,
                            evaluation: _evaluation,
                            recommendedProducts: _recommendedProducts,
                            ready: !isLoading,
                            scanning: false,
                            controlScan: (newValue){},
                            cameFromScan: false,
                          ),
                      ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
