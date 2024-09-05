import 'package:flutter/material.dart';

class Product extends StatefulWidget {
  final dynamic product;
  Product({
    Key? key,
    required this.product
  }) : super(key: key);

  @override
  _ProductState createState() => _ProductState();
}
class _ProductState extends State<Product> {
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
    return Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.grey.shade300,
              width: 1.0,
            ),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child:Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
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
                    "Barra proteina",
                    style: TextStyle(
                      fontFamily: "Gilroy-SemiBold",
                      fontSize: screenHeight * 0.025,
                      color: const Color(0xFF7448ED),
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Text(
                    "Wild food",
                    style: TextStyle(
                      fontFamily: "Gilroy-Medium",
                      fontSize: screenHeight * 0.02,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Text(
                    "78023764823",
                    style: TextStyle(
                      fontFamily: "Gilroy-Regular",
                      fontSize: screenHeight * 0.015,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              )
            ],
          )
        )
    );
  }
}