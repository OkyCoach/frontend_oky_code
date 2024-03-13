import 'package:flutter/material.dart';
import 'package:frontend_oky_code/widgets/v3_product_detail.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _ProfileState();
}

class _ProfileState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        width: screenWidth,
        child: ProductDetailV3(evaluation:{}, product: {})
      ),
    );
  }
}
