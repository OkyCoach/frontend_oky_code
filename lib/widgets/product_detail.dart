import 'package:flutter/material.dart';
import 'package:frontend_oky_code/widgets/recommended.dart';
import 'package:frontend_oky_code/widgets/details_components/product_info.dart';
import 'package:frontend_oky_code/widgets/details_components/product_tabs.dart';
import 'package:frontend_oky_code/widgets/details_components/product_tabs_content.dart';

class ProductDetail extends StatelessWidget {
  final dynamic data; // Objeto con atributos variables

  const ProductDetail({
    Key? key, 
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Column(
      
      children: [  
        DefaultTabController(
          length: 1, // Número de pestañas (Nutricionistas y Tabla Nutricional)
          child: Dialog(
            insetPadding: const EdgeInsets.only(top: 20, left: 10, right:10),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(25), // Solo los bordes superiores son redondeados
              ),
            ),
            elevation: 10,
            backgroundColor: const Color(0xFFFFFFFF),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.7,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ProductInfoRow(
                    photoUrl: data["ok_to_shop"]?["basicInformation"]?["photoUrl"] ?? "not_found",
                    description: data["ok_to_shop"]?["basicInformation"]?["description"] ?? "not_found",
                    brandName: (data["ok_to_shop"]?["basicInformation"]?["brands"]?.isNotEmpty ?? false)
                                ? (data["ok_to_shop"]["basicInformation"]["brands"][0]["name"] ?? 'not_found')
                                : 'not_found',            
                    starCount: 4, // Cambia esto según tu lógica
                    nutritionistsCount: 7, // Cambia esto según tu lógica
                  ),
                  /*
                  Text(
                    "Evaluación Nutricional",
                    style: TextStyle(
                      fontSize: screenHeight * 0.022,
                      fontFamily: "Gilroy-Bold",
                    ),
                  ),
                  */
                  const ProductTabs(),
                  ProductTabsContent(data: data),
                ],
              ), 
            ),
          ),
        ),
        const Recommended(data: {})       
      ]
    ); 
  }
}
