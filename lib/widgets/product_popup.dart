import 'package:flutter/material.dart';
import 'package:frontend_oky_code/widgets/product_detail.dart';

class ProductPopup extends StatelessWidget {
  final dynamic data; // Objeto con atributos variables

  const ProductPopup({
    super.key, 
    required this.data,
  });

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
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      elevation: 10,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.2,
        ),
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
                    height: 60,
                    width: 60,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data["basicInformation"]["description"],
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          Text(
                            data["basicInformation"]["brands"][0]["name"],
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          ),
                          Row(
                            children: [
                              Image.asset(
                                'lib/assets/Estrella_completa.png',
                                height: 20,
                                width: 20,
                              ),
                              Image.asset(
                                'lib/assets/Estrella_completa.png',
                                height: 20,
                                width: 20,
                              ),
                              Image.asset(
                                'lib/assets/Estrella_completa.png',
                                height: 20,
                                width: 20,
                              ),
                              Image.asset(
                                'lib/assets/Estrella_completa.png',
                                height: 20,
                                width: 20,
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: (){
                        _showProductDetails(context);
                      },
                      child: Image.asset(
                        "lib/assets/botones/Ver_producto.png",
                        height: 40, // Ajusta la altura según tus necesidades
                        width: 40, // Ajusta el ancho según tus necesidades
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Image.asset(
                      "lib/assets/Favorito.png",
                      height: 40, // Ajusta la altura según tus necesidades
                      width: 40, // Ajusta el ancho según tus necesidades
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
