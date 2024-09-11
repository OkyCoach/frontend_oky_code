import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:frontend_oky_code/widgets/popups/product.dart';
import 'package:frontend_oky_code/widgets/popups/not-found.dart';
import 'package:frontend_oky_code/widgets/popups/no-evaluation.dart';
import 'package:frontend_oky_code/helpers/fetch_data.dart';
import 'package:vibration/vibration.dart';
import 'package:frontend_oky_code/helpers/barcode_handler.dart';
import 'package:frontend_oky_code/widgets/popups/product-detail.dart';
import 'package:frontend_oky_code/widgets/recommended.dart';

class MyScannerWidget extends StatefulWidget {
  @override
  _MyScannerWidgetState createState() => _MyScannerWidgetState();
}

class _MyScannerWidgetState extends State<MyScannerWidget> {
  bool scanning = true;
  String? productBarcode = "";
  dynamic product = {};
  dynamic evaluation = {};
  late bool isLiked = false;
  late int likes = 0;
  List<dynamic> recommendedProducts = [];
  bool ready = false;
  bool showProductPopup = false;
  bool showDetail = false;
  bool showNotFound = false;
  bool showNotEvaluated= false;
  bool showBadConnection= false;

  Future<bool> _didScan(String? barcode) async {
    try {
      var _product = await fetchBarcodeData(barcode, true);
      var _evaluation = await fetchEvaluationData(barcode);
      setState(() {
        ready = false;
        evaluation = _evaluation;
        product = _product;
        productBarcode = barcode;
        isLiked = _product["liked"] ?? false;
        likes = _product["totalLikes"] ?? 0;
      });
      if(_product.containsKey('barcode') && _evaluation.containsKey('puntos_totales')){
        setState(() {
          showProductPopup = true;
        });
        List<dynamic> products = await fetchRecommendedProducts(product["barcode"]);
        setState(() {
          recommendedProducts = products;
          ready = true;
        });
      } else if(_product.containsKey('barcode') && !_evaluation.containsKey('puntos_totales')){
        setState(() {
          showNotEvaluated = true;
        });
      } else if(!_product.containsKey('barcode') && !_evaluation.containsKey('puntos_totales')){
        setState(() {
          showNotFound = true;
        });
      } else if(_product.containsKey('timeout') || _evaluation.containsKey('timeout')){
        setState(() {
          showBadConnection = true;
        });
      }
      return true;
    } catch (error) {
      return false;
    }
  }

  Future<bool> changeProduct(dynamic newProduct) async {
    try {
      setState(() {
        ready = false;
        evaluation = newProduct["algorithm"];
        product = newProduct["product"];
        isLiked =  newProduct["product"]["liked"] ?? false;
        likes =  newProduct["product"]["totalLikes"] ?? 0;
      });
      List<dynamic> products = await fetchRecommendedProducts(newProduct["product"]?["barcode"]);
      setState(() {
        recommendedProducts = products;
        ready = true;
      });
      return newProduct["product"]?["barcode"] != null && newProduct["algorithm"]?["puntos_totales"] != null;
    } catch (error) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: MobileScanner(
              fit: BoxFit.fill,
              controller: MobileScannerController(
                returnImage: false,
              ),
              onDetect: (capture) async {
                try {
                  if (scanning) {
                    setState(() {
                      scanning = false;
                    });

                    final List<Barcode> barcodes = capture.barcodes;
                    bool? hasVibrator = await Vibration.hasVibrator();

                    if (hasVibrator == true) {
                      Vibration.vibrate(duration: 100);
                    }
                    var barcode = barcodeHandler(barcodes[0]);
                    var result = await _didScan(barcode);
                  }
                } catch (e){
                  setState(() {
                    showNotFound = true;
                  });
                }
              },
            ),
          ),
          if(showNotFound)
            Align(
              alignment: Alignment.center,
              child: NotFoundPopup(
                barcode: productBarcode,
                showNotFound: (newValue){
                  setState(() {
                    showNotFound = newValue;
                  });
                },
                scanning: (newValue){
                  setState(() {
                    scanning = newValue;
                  });
                },
              )
            ),
          if(showNotEvaluated)
            Align(
              alignment: Alignment.center,
              child: NoEvaluationPopup(
                product: product,
                showNotEvaluated: (newValue){
                  setState(() {
                    showNotEvaluated = newValue;
                  });
                },
                scanning: (newValue){
                  setState(() {
                    scanning = newValue;
                  });
                },
              )
            ),
          if(showProductPopup)
            Align(
              alignment: Alignment.center,
              child: ProductPopup(
                product: product,
                evaluation: evaluation,
                showPopUp: (newValue) {
                  setState(() {
                    showProductPopup = newValue;
                  });
                },
                scanning: (newValue) {
                  setState(() {
                    scanning = newValue;
                  });
                },
                showDetails: (newValue) {
                  setState(() {
                    showDetail = newValue;
                  });
                },
                isLiked: isLiked,
                likes: likes,
                changeLike: (newValue){
                  setState(() {
                    setState(() {
                      isLiked = newValue;
                      if(newValue){
                        likes += 1;
                      } else {
                        likes -= 1;
                      }
                    });
                  });
                },
              ),

            ),
          if(showDetail)
            Align(
              alignment: Alignment.bottomCenter,
              child: ProductDetailV3(
                product: product,
                evaluation: evaluation,
                isLiked: isLiked,
                changeLike: (newValue){
                  setState(() {
                    setState(() {
                      isLiked = newValue;
                      if(newValue){
                        likes += 1;
                      } else {
                        likes -= 1;
                      }
                    });
                  });
                },
                recommendedProducts: recommendedProducts,
                ready: ready,
                changeProduct: changeProduct,
                showDetails: (newValue) {
                  setState(() {
                    showDetail = newValue;
                  });
                },
                scanning: (newValue) {
                  setState(() {
                    scanning = newValue;
                  });
                },
              ),
            ),
          if(showProductPopup)
            Align(
              alignment: Alignment.bottomCenter,
              child: Recommended(
                recommendedProducts: recommendedProducts,
                ready: ready,
                cameFromScan: true,
                showDetails: (newValue) {
                  setState(() {
                    showDetail = newValue;
                    showProductPopup = !newValue;
                  });
                },
                changeProduct: changeProduct,
              )
          )
        ],
      ),
    );
  }

}
