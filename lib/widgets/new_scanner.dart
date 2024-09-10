import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:frontend_oky_code/widgets/product_popup.dart';
import 'package:frontend_oky_code/widgets/not_found_popup.dart';
import 'package:frontend_oky_code/widgets/no_evaluation_popup.dart';
import 'package:frontend_oky_code/widgets/bad_connection_popup.dart';
import 'package:frontend_oky_code/helpers/fetch_data.dart';
import 'package:vibration/vibration.dart';
import 'package:frontend_oky_code/helpers/barcode_handler.dart';
import 'package:frontend_oky_code/widgets/v3_product_detail.dart';

class MyScannerWidget extends StatefulWidget {
  @override
  _MyScannerWidgetState createState() => _MyScannerWidgetState();
}

class _MyScannerWidgetState extends State<MyScannerWidget> {
  bool scanning = false;
  dynamic product = {};
  dynamic evaluation = {};
  bool showDetail = false;

  Future<bool> _didScan(String? barcode) async {
    var _product = await fetchBarcodeData(barcode, true);
    var _evaluation = await fetchEvaluationData(barcode);
    setState(() {
      evaluation = _evaluation;
      product = _product;
    });
    return _product["barcode"] != null && _evaluation["puntos_totales"] != null;
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
                if (!scanning) {
                  setState(() {
                    scanning = true;
                  });

                  final List<Barcode> barcodes = capture.barcodes;
                  bool? hasVibrator = await Vibration.hasVibrator();

                  if (hasVibrator == true) {
                    Vibration.vibrate(duration: 100);
                  }
                  var barcode = barcodeHandler(barcodes[0]);
                  var result = await _didScan(barcode);
                  if (result == true) {
                    setState(() {
                      showDetail = true;
                    });
                  }
                }
              },
            ),
          ),
          if(showDetail)
            Align(
              alignment: Alignment.bottomCenter,
              child: ProductDetailV3(
                product: product,
                evaluation: evaluation,
              ),
            ),
        ],
      ),
    );
  }

}
