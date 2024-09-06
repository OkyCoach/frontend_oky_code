import 'package:flutter/material.dart';
import 'package:frontend_oky_code/widgets/search/Product.dart';
import 'package:frontend_oky_code/widgets/search/Searchbar.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final _filterController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
          child: Padding(padding: EdgeInsets.only(top: 10),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      "Productos favoritos",
                      style: TextStyle(
                        fontFamily: "Gilroy-SemiBold",
                        fontSize: screenHeight * 0.025,
                        color: Colors.grey.shade800,
                      ),
                    ),
                  ),
                  SizedBox(height: 5,),
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
