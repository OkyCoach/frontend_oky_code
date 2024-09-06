import 'package:flutter/material.dart';
import 'package:frontend_oky_code/widgets/dismissible_bar.dart';
import 'package:frontend_oky_code/helpers/fetch_data.dart';

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
      fetchProductReview(barcode);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> fetchProductReview(String barcode) async {
    var evaluation = await fetchEvaluationData(barcode);
    setState(() {
      _evaluation = evaluation;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return SlideTransition(
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
            padding: EdgeInsets.all(10),
            child:  Column(
              children: [
                const DismissibleBar(width: 40),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child:Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      widget.product["photoUrl"] != null
                          ? Image.network(
                        widget.product["photoUrl"],
                        height: screenHeight * 0.1,
                        width: screenHeight * 0.1,
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
                      SizedBox(width: 10,),
                      Column(
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
                          )
                        ],
                      )
                    ],
                  )
                )
              ],
            )
          )
        )
      ),
    );
  }
}
