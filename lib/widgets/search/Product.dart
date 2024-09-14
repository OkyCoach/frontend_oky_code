import 'package:flutter/material.dart';
import 'package:frontend_oky_code/widgets/history/product_detail_sheet.dart';
import 'package:frontend_oky_code/widgets/details_components/like-button.dart';

class Product extends StatefulWidget {
  final dynamic product;
  final bool liked;
  final showLike;
  Product({
    Key? key,
    required this.product,
    required this.liked,
    required this.showLike,
  }) : super(key: key);

  @override
  _ProductState createState() => _ProductState();
}
class _ProductState extends State<Product> {
  late bool isLiked = false;

  @override
  void initState() {
    super.initState();
    isLiked = widget.liked;
  }

  void _showProductDetailSheet(BuildContext context, dynamic product) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ProductDetailSheet(product: product);
      },
      isScrollControlled: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    double screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    return GestureDetector(
        onTap: () => _showProductDetailSheet(context, widget.product),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey.shade300,
              width: 1.0,
            ),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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
              SizedBox(width: 10,),
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
                    Text(
                      widget.product["barcode"] ?? 'not_found',
                      style: TextStyle(
                        fontFamily: "Gilroy-Regular",
                        fontSize: screenHeight * 0.015,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 2,),
              if(widget.showLike)
                LikeButton(
                  isLiked: isLiked,
                  changeLike: (newValue){
                    setState(() {
                      isLiked = newValue;
                    });
                  },
                  productId: widget.product.containsKey("product_id")
                      ? widget.product["product_id"]
                      : widget.product["_id"],
                )
            ],
          ),
        ),
      ),
    );
  }
}