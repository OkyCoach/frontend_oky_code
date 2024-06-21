import 'package:mobile_scanner/mobile_scanner.dart';

String barcodeHandler(Barcode barcode) {
  var format = barcode.format.toString().split(".")[1];
  if (format == "upcA") {
    return barcode.rawValue!.substring(1);
  } else {
    return barcode.rawValue!;
  }
}
