import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:frontend_oky_code/widgets/product_popup.dart';
import 'package:frontend_oky_code/widgets/not_found_popup.dart';
import 'package:frontend_oky_code/widgets/no_evaluation_popup.dart';
import 'package:frontend_oky_code/widgets/bad_connection_popup.dart';
import 'package:frontend_oky_code/helpers/fetch_data.dart';
import 'package:vibration/vibration.dart';
import 'package:frontend_oky_code/helpers/barcode_handler.dart';

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
      body: SizedBox(
        width: double.infinity, // Ocupa todo el ancho de la pantalla
        height: double.infinity, // Ocupa todo el alto de la pantalla
        child: MobileScanner(
          fit: BoxFit.fill, // Para que el escáner llene el contenedor
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
              bool? hasVibrator = await Vibration.hasVibrator();

              // Realizar vibración leve si el dispositivo tiene vibrador
              if (hasVibrator == true) {
                // Verifica que hasVibrator sea true, no nulo
                Vibration.vibrate(duration: 100);
              }
              var barcode = barcodeHandler(barcodes[0]);
              var scanResult = await _didScan(barcode);

              showDialog(
                  barrierDismissible: false,
                  barrierColor: Colors.white.withOpacity(0),
                  context: context,
                  builder: (_) {
                    if (scanResult["product"].containsKey('timeout') ||
                        scanResult["evaluation"].containsKey('timeout')) {
                      return BadConnetionPopup(
                          scanning: scanning,
                          controlScan: (newValue) {
                            setState(() {
                              scanning = newValue;
                            });
                          });
                    } else if (scanResult["product"]["barcode"] != null &&
                        scanResult["evaluation"]["puntos_obtenidos"] != null) {
                      return ProductPopup(
                          product: scanResult["product"],
                          evaluation: scanResult["evaluation"],
                          scanning: scanning,
                          controlScan: (newValue) {
                            setState(() {
                              scanning = newValue;
                            });
                          });
                    } else if (scanResult["product"]["barcode"] != null &&
                        scanResult["evaluation"]["puntos_obtenidos"] == null) {
                      return NoEvaluationPopup(
                          product: scanResult["product"],
                          scanning: scanning,
                          controlScan: (newValue) {
                            setState(() {
                              scanning = newValue;
                            });
                          });
                    } else {
                      return NotFoundPopup(
                          barcode: barcode,
                          scanning: scanning,
                          controlScan: (newValue) {
                            setState(() {
                              scanning = newValue;
                            });
                          });
                    }
                  });
            }
          },
        ),
      ),
    );
  }
}
