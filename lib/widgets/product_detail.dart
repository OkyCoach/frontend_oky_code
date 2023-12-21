import 'package:flutter/material.dart';
import 'package:frontend_oky_code/widgets/nutricionist_evaluation.dart';

class ProductDetail extends StatelessWidget {
  final dynamic data; // Objeto con atributos variables

  const ProductDetail({
    Key? key, 
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Número de pestañas (Nutricionistas y Tabla Nutricional)
      child: Dialog(
        insetPadding: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        elevation: 10,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.9,
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
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
                                        'lib/assets/estrella_completa.png',
                                        height: 20,
                                        width: 20,
                                      ),
                                      Image.asset(
                                        'lib/assets/estrella_completa.png',
                                        height: 20,
                                        width: 20,
                                      ),
                                      Image.asset(
                                        'lib/assets/estrella_completa.png',
                                        height: 20,
                                        width: 20,
                                      ),
                                      Image.asset(
                                        'lib/assets/estrella_completa.png',
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

                // TabBar para cambiar entre Nutricionistas y Tabla Nutricional
                const TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorColor: Color(0xFF76FDB1),
                  labelColor: Colors.black,
                  indicatorWeight: 8.0,
                  labelPadding: EdgeInsets.symmetric(horizontal: 1.0),
                  tabs: [
                    Tab(
                      child: Text(
                        "Nutricionistas",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Tabla Nutricional",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),

                // Contenido de las pestañas
                Expanded(
                  child: TabBarView(
                    children: [
                      // Contenido de la pestaña Nutricionistas
                      Center(
                        child: NutricionistEvaluation(data: data),
                      ),

                      // Contenido de la pestaña Tabla Nutricional
                      const Center(
                        child: Text("Contenido Tabla Nutricional"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          
        ),
      ),
    );
  }
}
