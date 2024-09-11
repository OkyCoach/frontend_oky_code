import 'package:flutter/material.dart';
import 'package:frontend_oky_code/widgets/search/Product.dart';
import 'package:frontend_oky_code/widgets/search/Searchbar.dart';
import 'package:frontend_oky_code/helpers/fetch_data.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _ProfileState();
}

class _ProfileState extends State<SearchPage> {
  final _filterController = TextEditingController();
  List<dynamic> products = [];
  bool isLoading = false;

  void _onSearch() async {
    try {
      setState(() {
        isLoading = true;
      });
      var result = await searchProducts(_filterController.text);
      setState(() {
        products = result;
        isLoading = false;
      });
    }catch(e) {
    }
  }

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
                  onSearch: _onSearch,
                ),
                SizedBox(height: 10,),
                Expanded(
                  child: isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : products.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Agregar imagen
                                  Image.asset(
                                    'lib/assets/lupa.png', // Ruta de la imagen
                                    height: 120, // Tamaño ajustado
                                    color: Colors.grey.shade300, // El color que quieres aplicar a la imagen
                                    colorBlendMode: BlendMode.srcIn,
                                  ),
                                  const SizedBox(height: 20), // Espacio entre imagen y texto
                                  const Text(
                                    "Puedes buscar productos por nombre, marca o código de barras.",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      letterSpacing: 1,
                                      fontFamily: "Gilroy-Medium",
                                      color: Colors.grey,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : ListView.builder(
                              itemCount: products.length,
                              itemBuilder: (context, index) {
                                var product = products[index];
                                return Product(
                                  product: product,
                                  liked: false,
                                );
                              },
                            ),
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}
