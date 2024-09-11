import 'package:flutter/material.dart';
import 'package:frontend_oky_code/widgets/search/Product.dart';
import 'package:frontend_oky_code/helpers/fetch_data.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<dynamic> _products = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFavoritesProducts();
  }

  Future<void> _loadFavoritesProducts() async {
    try {
      List<dynamic> products = await favoritesProducts();
      setState(() {
        _products = products;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

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
                  _isLoading
                      ? Expanded(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )

                      : Expanded(
                          child: ListView.builder(
                            itemCount: _products.length,
                            itemBuilder: (context, index) {
                              return Product(
                                product: _products[index],
                                liked: true,
                              );
                            },
                          ),
                        )
                ],
              ),
            ),
          )
      ),
    );
  }
}
