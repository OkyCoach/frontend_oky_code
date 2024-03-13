import 'package:flutter/material.dart';
import 'package:frontend_oky_code/widgets/recommended.dart';
import 'package:frontend_oky_code/widgets/dismissible_bar.dart';
import 'package:frontend_oky_code/widgets/details_components/product_info.dart';
import 'package:frontend_oky_code/widgets/details_components/product_tabs.dart';
import 'package:frontend_oky_code/widgets/details_components/product_tabs_content.dart';


class ProductDetailV3 extends StatelessWidget {
  final dynamic product; // Objeto con atributos variables
  final dynamic evaluation;

  const ProductDetailV3({
    Key? key,
    required this.product,
    required this.evaluation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double margins = 0.04;
    /*
    String photoUrl = product["ok_to_shop"]?["basicInformation"]
            ?["photoUrl"] ??
        "not_found";
    String description = product["ok_to_shop"]?["basicInformation"]
            ?["description"] ??
        "not_found";
    String brandName = (product["ok_to_shop"]?["basicInformation"]
                ?["brands"]
                ?.isNotEmpty ??
            false)
        ? (product["ok_to_shop"]["basicInformation"]["brands"][0]
                ["name"] ??
            'not_found')
        : 'not_found';
    */
    return DefaultTabController(
      length: 1,
      child: Container(
        margin: EdgeInsets.only(bottom: screenHeight * 0.07),
        width: screenWidth,
        color: Colors.blue,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: screenWidth * margins),
              padding: const EdgeInsets.only(
                  top: 10, left: 5, right: 5),
              height: 200,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.0),
                  topRight: Radius.circular(25.0),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const DismissibleBar(width: 40),
                  /*
                  ProductInfoRow(
                    photoUrl: photoUrl,
                    description: description,
                    brandName: brandName,
                    evaluation: evaluation,
                  ),
                  */
                  const ProductTabs(),
                ],
              )
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Text("HOLA")/*
                  ListView(
                    padding: const EdgeInsets.all(0),
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: screenWidth * margins),
                        color: Colors.white,
                        child: Text("HOLA")
                      ),
                      //Recommended(recommendedProducts: recommendedProducts)
                    ],
                  ),
                  */
                  
                ],
              ),
            ),
          ]
        ),
      )
    );
  }
}
