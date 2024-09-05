import 'package:flutter/material.dart';
import 'package:frontend_oky_code/widgets/search/Product.dart';
import 'package:frontend_oky_code/widgets/search/Searchbar.dart';
import 'package:frontend_oky_code/helpers/fetch_data.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryState();
}

class _HistoryState extends State<HistoryPage> {
  final _filterController = TextEditingController();
  List<dynamic> _products = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProductHistory();
  }

  Future<void> _loadProductHistory() async {
    try {
      List<dynamic> products = await scannedProductsHistory();
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
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
          child: Padding(padding: EdgeInsets.only(top: 10),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _isLoading
                    ? CircularProgressIndicator()
                    : Expanded(
                      child: ListView.builder(
                        itemCount: _products.length,
                        itemBuilder: (context, index) {
                          return Product(product: _products[index]);
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
