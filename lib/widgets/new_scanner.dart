import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:frontend_oky_code/widgets/not_found_popup.dart';

class MyScannerWidget extends StatefulWidget {
  @override
  _MyScannerWidgetState createState() => _MyScannerWidgetState();
}

class _MyScannerWidgetState extends State<MyScannerWidget> {
  bool scanning = false;

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
        onDetect: (capture) {
          if (!scanning) {
            setState(() {
              scanning = true;
            });

            final List<Barcode> barcodes = capture.barcodes;
            showDialog(
              barrierColor: Colors.white.withOpacity(0),
              context: context,
              builder: (_) {
                return NotFoundPopup(barcode: "3483494");
              },
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
