import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:frontend_oky_code/widgets/product_popup.dart';
import 'package:frontend_oky_code/widgets/not_found_popup.dart';
import 'package:frontend_oky_code/widgets/no_evaluation_popup.dart';
import 'package:frontend_oky_code/helpers/fetch_data.dart';

class MyScannerWidget extends StatefulWidget {
  @override
  _MyScannerWidgetState createState() => _MyScannerWidgetState();
}

class _MyScannerWidgetState extends State<MyScannerWidget> {
  bool scanning = false;

  Future<Map<String, dynamic>> _didScan(String? barcode) async {
    var product = await fetchBarcodeData(barcode);
    var evaluation = await fetchEvaluationData(barcode);
    return {'product': product, 'evaluation': evaluation};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MobileScanner(
        fit: BoxFit.contain,
        controller: MobileScannerController(
          // facing: CameraFacing.back,
          // torchEnabled: false,
          returnImage: false,
        ),
        onDetect: (capture) async {
          if (!scanning) {
            setState(() {
              scanning = true;
            });

            final List<Barcode> barcodes = capture.barcodes;
            var scanResult = await _didScan(barcodes[0].rawValue);

            showDialog(
              barrierColor: Colors.white.withOpacity(0),
              context: context,
              builder: (_) {
                if (scanResult["product"]["barcode"] != null && scanResult["evaluation"]["puntos_obtenidos"] != null) {
                  return ProductPopup(product: scanResult["product"], evaluation: scanResult["evaluation"], canScan: true,);
                } else if (scanResult["product"]["barcode"] != null && scanResult["evaluation"]["puntos_obtenidos"] == null) {
                  return NoEvaluationPopup(product: scanResult["product"]);
                } else {
                  return NotFoundPopup(barcode: barcodes[0].rawValue);
                }
              }
            ).then((_) {
              setState(() {
                scanning = false;
              });
            });
          }
        },
      ),
    );
  }
}
