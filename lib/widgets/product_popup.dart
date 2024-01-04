import 'package:flutter/material.dart';
import 'package:frontend_oky_code/widgets/product_detail.dart';

class ProductPopup extends StatelessWidget {
  final dynamic data; // Objeto con atributos variables

  const ProductPopup({
    Key? key,
    required this.data,
  }) : super(key: key);

  void _showProductDetails(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ProductDetail(
          data: data,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Dialog(
      insetPadding: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      elevation: 1,
      child: IntrinsicHeight(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.network(
                    data["basicInformation"]["photoUrl"],
                    height: screenHeight * 0.1,
                    width: screenHeight * 0.1,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data["basicInformation"]["description"],
                            style: TextStyle(
                              fontSize: screenHeight * 0.02,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF7448ED),
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          Text(
                            data["basicInformation"]["brands"][0]["name"],
                            style: TextStyle(
                              fontSize: screenHeight * 0.02,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Row(
                              children: [
                                for (int i = 0; i < 4; i++)
                                  Padding(
                                    padding: const EdgeInsets.only(right: 3),
                                    child: Image.asset(
                                      'lib/assets/estrella_completa.png',
                                      width: screenHeight * 0.03,
                                    ),
                                  ),
                              ],
                            )
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        _showProductDetails(context);
                      },
                      child: Image.asset(
                        "lib/assets/botones/ver_producto.png",
                        height: screenHeight * 0.05,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: ClipOval(
                        child: ColorFiltered(
                          colorFilter: const ColorFilter.mode(
                            Color(0xFFE8E4F4),
                            BlendMode.color,
                          ),
                          child: Image.asset(
                            'lib/assets/favorito.png',
                            height: screenHeight * 0.05,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}
