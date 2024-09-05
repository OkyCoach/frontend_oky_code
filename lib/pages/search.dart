import 'package:flutter/material.dart';
import 'package:frontend_oky_code/widgets/search/Product.dart';
import 'package:frontend_oky_code/widgets/search/Searchbar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _ProfileState();
}

class _ProfileState extends State<SearchPage> {
  final _filterController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Padding(padding: EdgeInsets.only(top: 10),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomSearchBar(
                  controller: _filterController,
                ),
                SizedBox(height: 10,),
                Expanded(
                  child: ListView(
                    children: [
                      Product(product: {}),
                      Product(product: {}),
                      Product(product: {})
                    ],
                  )
                )
              ],
            ),
          ),
        )
      ),
    );
  }
}
