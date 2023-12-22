import 'package:flutter/material.dart';

class NutricionistEvaluation extends StatelessWidget {
  final dynamic data; // Objeto con atributos variables

  const NutricionistEvaluation({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF7448ED),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0), // Espacio de padding para el Row
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xFF201547), // Color del borde inferior
                    width: 1.0, // Ancho del borde inferior
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClipOval(
                    child: ColorFiltered(
                      colorFilter: const ColorFilter.mode(
                        Color(0xFFE8E4F4),
                        BlendMode.color,
                      ),
                      child: Image.asset(
                        'lib/assets/azucar.png',
                        height: 50,
                        width: 50,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Azucares totales',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Row(
                            children: [
                              Image.asset(
                                'lib/assets/estrella_completa.png',
                                height: 20,
                                width: 20,
                              ),
                              const SizedBox(
                                width: 2,
                              ),
                              Image.asset(
                                'lib/assets/estrella_completa.png',
                                height: 20,
                                width: 20,
                              ),
                              const SizedBox(
                                width: 2,
                              ),
                              Image.asset(
                                'lib/assets/estrella_completa.png',
                                height: 20,
                                width: 20,
                              ),
                              const SizedBox(
                                width: 2,
                              ),
                              Image.asset(
                                'lib/assets/estrella_completa.png',
                                height: 20,
                                width: 20,
                              ),
                              const SizedBox(
                                width: 2,
                              ),
                              Image.asset(
                                'lib/assets/estrella_vacia.png',
                                height: 20,
                                width: 20,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0), // Espacio de padding para el Row
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xFF201547), // Color del borde inferior
                    width: 1.0, // Ancho del borde inferior
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClipOval(
                    child: ColorFiltered(
                      colorFilter: const ColorFilter.mode(
                        Color(0xFFE8E4F4),
                        BlendMode.color,
                      ),
                      child: Image.asset(
                        'lib/assets/numero_ingredientes.png',
                        height: 50,
                        width: 50,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Numero de Ingredientes',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Row(
                            children: [
                              Image.asset(
                                'lib/assets/estrella_completa.png',
                                height: 20,
                                width: 20,
                              ),
                              const SizedBox(
                                width: 2,
                              ),
                              Image.asset(
                                'lib/assets/estrella_completa.png',
                                height: 20,
                                width: 20,
                              ),
                              const SizedBox(
                                width: 2,
                              ),
                              Image.asset(
                                'lib/assets/estrella_completa.png',
                                height: 20,
                                width: 20,
                              ),
                              const SizedBox(
                                width: 2,
                              ),
                              Image.asset(
                                'lib/assets/estrella_completa.png',
                                height: 20,
                                width: 20,
                              ),
                              const SizedBox(
                                width: 2,
                              ),
                              Image.asset(
                                'lib/assets/estrella_vacia.png',
                                height: 20,
                                width: 20,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0), // Espacio de padding para el Row
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xFF201547), // Color del borde inferior
                    width: 1.0, // Ancho del borde inferior
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClipOval(
                    child: ColorFiltered(
                      colorFilter: const ColorFilter.mode(
                        Color(0xFFE8E4F4),
                        BlendMode.color,
                      ),
                      child: Image.asset(
                        'lib/assets/calidad_ingredientes.png',
                        height: 50,
                        width: 50,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Calidad de Ingredientes',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Row(
                            children: [
                              Image.asset(
                                'lib/assets/estrella_completa.png',
                                height: 20,
                                width: 20,
                              ),
                              const SizedBox(
                                width: 2,
                              ),
                              Image.asset(
                                'lib/assets/estrella_completa.png',
                                height: 20,
                                width: 20,
                              ),
                              const SizedBox(
                                width: 2,
                              ),
                              Image.asset(
                                'lib/assets/estrella_completa.png',
                                height: 20,
                                width: 20,
                              ),
                              const SizedBox(
                                width: 2,
                              ),
                              Image.asset(
                                'lib/assets/estrella_completa.png',
                                height: 20,
                                width: 20,
                              ),
                              const SizedBox(
                                width: 2,
                              ),
                              Image.asset(
                                'lib/assets/estrella_vacia.png',
                                height: 20,
                                width: 20,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0), // Espacio de padding para el Row
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xFF201547), // Color del borde inferior
                    width: 1.0, // Ancho del borde inferior
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClipOval(
                    child: ColorFiltered(
                      colorFilter: const ColorFilter.mode(
                        Color(0xFFE8E4F4),
                        BlendMode.color,
                      ),
                      child: Image.asset(
                        'lib/assets/naturalidad.png',
                        height: 50,
                        width: 50,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Naturalidad del producto',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Row(
                            children: [
                              Image.asset(
                                'lib/assets/estrella_completa.png',
                                height: 20,
                                width: 20,
                              ),
                              const SizedBox(
                                width: 2,
                              ),
                              Image.asset(
                                'lib/assets/estrella_completa.png',
                                height: 20,
                                width: 20,
                              ),
                              const SizedBox(
                                width: 2,
                              ),
                              Image.asset(
                                'lib/assets/estrella_completa.png',
                                height: 20,
                                width: 20,
                              ),
                              const SizedBox(
                                width: 2,
                              ),
                              Image.asset(
                                'lib/assets/estrella_completa.png',
                                height: 20,
                                width: 20,
                              ),
                              const SizedBox(
                                width: 2,
                              ),
                              Image.asset(
                                'lib/assets/estrella_vacia.png',
                                height: 20,
                                width: 20,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
