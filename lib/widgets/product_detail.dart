import 'package:flutter/material.dart';

class ProductDetail extends StatelessWidget {
  final dynamic data; // Objeto con atributos variables

  const ProductDetail({
    super.key, 
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      elevation: 10,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.9,
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.network(
                    data["basicInformation"]["photoUrl"],
                    height: 80,
                    width: 80,
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
                              fontSize: 14,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
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
                              ),
                              const Text(
                                "Evaluado por 7 nutricionistas",
                                style: TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                            ]
                          ) 
                        ],
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              const Text(
                "Evaluación Nutricional",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Nutricionistas",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    "Tabla Nutricional",
                    style: TextStyle(
                      fontSize: 18,
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
