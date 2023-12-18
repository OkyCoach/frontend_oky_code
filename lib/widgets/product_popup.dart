import 'package:flutter/material.dart';

class ProductPopup extends StatelessWidget {
  final dynamic data; // Objeto con atributos variables

  const ProductPopup({
    super.key, 
    required this.data,
  });

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
                  Image.asset(
                    'lib/assets/Lupa.png',
                    height: 40,
                    width: 40,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Puff Manzana Arándano',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          const Text(
                            'PUFF FOODS',
                            style: TextStyle(
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
                      onTap: () {
                        Navigator.of(context).pop();
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
