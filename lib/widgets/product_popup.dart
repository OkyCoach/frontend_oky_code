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
    double popupHeight = screenHeight * 0.2;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      elevation: 10,
      child: SizedBox(
        height: popupHeight,
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
                    height: popupHeight * 0.4, // Ajusta según tus necesidades
                    width: popupHeight * 0.4, // Ajusta según tus necesidades
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
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          Text(
                            data["basicInformation"]["brands"][0]["name"],
                            style: const TextStyle(
                              fontSize: 10,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              for (int i = 0; i < 4; i++)
                                Padding(
                                  padding: const EdgeInsets.only(right: 3),
                                  child: Image.asset(
                                    'lib/assets/estrella_completa.png',
                                    height: popupHeight *
                                        0.1, // Ajusta según tus necesidades
                                    width: popupHeight *
                                        0.1, // Ajusta según tus necesidades
                                  ),
                                ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      _showProductDetails(context);
                    },
                    child: Image.asset(
                      "lib/assets/botones/ver_producto.png",
                      height:
                          popupHeight * 0.22, // Ajusta según tus necesidades,
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
                          height: popupHeight * 0.22,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
