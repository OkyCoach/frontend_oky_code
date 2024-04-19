import 'package:flutter/material.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:scandit_flutter_datacapture_barcode/scandit_flutter_datacapture_barcode.dart';
import 'package:scandit_flutter_datacapture_barcode/scandit_flutter_datacapture_barcode_capture.dart';
import 'package:scandit_flutter_datacapture_core/scandit_flutter_datacapture_core.dart';
import 'package:frontend_oky_code/widgets/product_popup.dart';
import 'package:frontend_oky_code/widgets/not_found_popup.dart';
import 'package:frontend_oky_code/widgets/no_evaluation_popup.dart';
import 'package:frontend_oky_code/helpers/fetch_data.dart';

const String licenseKey =
    'AUjUqjLeFlQDOOOzAhjZXiIxYoXuBI5/wEN2hTlXwRTrXmNEMWu9YlZ2u35cSZ3jMGjaseVfcp0qQcYiAXZlVLRipwTFDPfrQQFRVIU11bQoF7nXqjEq62NQEzB5pq2Q3LqHMt1Lvp/DiB4I03mUcv/qbzg+oOzxUZIXTu1zhKHi790SH7w0sLBbcOQJmDawrWgTHY5CwmDTEcvFeCuhQM6Ir8h0Ty1OZSLim8WSJD45mUWCzw36BoLWaZRYy0xRqQ4ohXgAR2EaLlVjA0EQUIj7CwQ5LPXm8kOvvPyCjHnqbaJE2dQXZije2pTlYrwV9gAX+sMH/bgj6DcIq/i/uwgF/ooYU6bOX0N0fj/8QEWLlpi1x0LwSfVWy9JHL23YlaoX105drUM9Mw2qVsF1exF57L8opLA1FkW5/F2viC+3ikbgw13YEAUl/fg9LPVxmCPvVVPPLs2YXFaUamuZ5EchP//oocLtXks3ViwKh3waOYKHmjTeBZQtvpIuRsohYUTC31+cvIaF/8XexAjGVubqk9ihwnLqpo0sM0LTENJMdndmYMJRN5a878PUxk69DbXPf5+q3uWYbPyiV34/Gs/FRa87GBHaEJt1vtWUTZ8aqrfKi8xk+70RvIOILLCp4UBvXZBd/z2gZ7JHmBq+4Ttu0in2yxx8msdtI39yg7ANbv4bmxXlblzAWWVbZ6iFt/ldNVWYfDHTwv0PVyRLitAwvDbgpwSKAdoO1xm3hnllahrAI5I/rEsZRfwlcnRnSogS862dMH/7YygSdskFERMA/5gRtlNi';

class BarcodeScannerScreen extends StatefulWidget {
  // Create data capture context using your license key.
  @override
  State<StatefulWidget> createState() =>
      _BarcodeScannerScreenState(DataCaptureContext.forLicenseKey(licenseKey));
}

class _BarcodeScannerScreenState extends State<BarcodeScannerScreen>
    with WidgetsBindingObserver
    implements BarcodeCaptureListener {
  final DataCaptureContext _context;

  // Use the world-facing (back) camera.
  Camera? _camera = Camera.defaultCamera;
  late BarcodeCapture _barcodeCapture;
  late DataCaptureView _captureView;

  bool canScan = false;

  bool _isPermissionMessageVisible = false;

  _BarcodeScannerScreenState(this._context);

  void _checkPermission() {
    Permission.camera.request().isGranted.then((value) => setState(() {
          _isPermissionMessageVisible = !value;
          if (value) {
            _camera?.switchToDesiredState(FrameSourceState.on);
          }
        }));
  }

  @override
  void initState() {
    super.initState();
    _ambiguate(WidgetsBinding.instance)?.addObserver(this);

    // Use the recommended camera settings for the BarcodeCapture mode.
    _camera?.applySettings(BarcodeCapture.recommendedCameraSettings);

    // Switch camera on to start streaming frames and enable the barcode tracking mode.
    // The camera is started asynchronously and will take some time to completely turn on.
    _checkPermission();

    // The barcode capture process is configured through barcode capture settings
    // which are then applied to the barcode capture instance that manages barcode capture.
    var captureSettings = BarcodeCaptureSettings();

    // The settings instance initially has all types of barcodes (symbologies) disabled. For the purpose of this
    // sample we enable a very generous set of symbologies. In your own app ensure that you only enable the
    // symbologies that your app requires as every additional enabled symbology has an impact on processing times.
    captureSettings.enableSymbologies({
      Symbology.ean8,
      Symbology.ean13Upca,
      Symbology.upce,
      Symbology.dataMatrix,
      Symbology.code39,
      Symbology.code128,
      Symbology.interleavedTwoOfFive
    });

    // Some linear/1d barcode symbologies allow you to encode variable-length data. By default, the Scandit
    // Data Capture SDK only scans barcodes in a certain length range. If your application requires scanning of one
    // of these symbologies, and the length is falling outside the default range, you may need to adjust the "active
    // symbol counts" for this symbology. This is shown in the following few lines of code for one of the
    // variable-length symbologies.
    captureSettings.settingsForSymbology(Symbology.code39).activeSymbolCounts =
        [for (var i = 7; i <= 20; i++) i].toSet();

    // Create new barcode capture mode with the settings from above.
    _barcodeCapture = BarcodeCapture.forContext(_context, captureSettings)
      // Register self as a listener to get informed whenever a new barcode got recognized.
      ..addListener(this);

    // To visualize the on-going barcode capturing process on screen, setup a data capture view that renders the
    // camera preview. The view must be connected to the data capture context.
    _captureView = DataCaptureView.forContext(_context);

    // Add a barcode capture overlay to the data capture view to render the location of captured barcodes on top of
    // the video preview. This is optional, but recommended for better visual feedback.
    var overlay = BarcodeCaptureOverlay.withBarcodeCaptureForViewWithStyle(
        _barcodeCapture, _captureView, BarcodeCaptureOverlayStyle.frame)
      ..viewfinder = RectangularViewfinder.withStyleAndLineStyle(
          RectangularViewfinderStyle.square,
          RectangularViewfinderLineStyle.light);

    // Adjust the overlay's barcode highlighting to match the new viewfinder styles and improve the visibility of feedback.
    // With 6.10 we will introduce this visual treatment as a new style for the overlay.
    overlay.brush = Brush(
        Color.fromARGB(0, 0, 0, 0), Color.fromARGB(255, 255, 255, 255), 3);

    _captureView.addOverlay(overlay);

    // Set the default camera as the frame source of the context. The camera is off by
    // default and must be turned on to start streaming frames to the data capture context for recognition.
    if (_camera != null) {
      _context.setFrameSource(_camera!);
    }
    _camera?.switchToDesiredState(FrameSourceState.on);
    _barcodeCapture.isEnabled = true;
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (_isPermissionMessageVisible) {
      child = const Text('No permission to access the camera!',
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black));
    } else {
      child = _captureView;
    }
    return WillPopScope(
        child: Center(child: child),
        onWillPop: () {
          dispose();
          return Future.value(true);
        });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _checkPermission();
    } else if (state == AppLifecycleState.paused) {
      _camera?.switchToDesiredState(FrameSourceState.off);
    }
  }

  @override
  void didScan(
      BarcodeCapture barcodeCapture, BarcodeCaptureSession session) async {
    _barcodeCapture.isEnabled = canScan;
    var code = session.newlyRecognizedBarcodes.first;
    var data = (code.data == null || code.data?.isEmpty == true)
        ? code.rawData
        : code.data;
    var product = await fetchBarcodeData(data);
    var evaluation = await fetchEvaluationData(data);
    await showDialog(
        barrierColor: Colors.white.withOpacity(0),
        context: context,
        builder: (_) {
          return Column();
          if (product["barcode"] != null &&
              evaluation["puntos_obtenidos"] != null) {
            //return ProductPopup(product: product, evaluation: evaluation);
            //return NoEvaluationPopup(product: product);
          } else if (product["barcode"] != null &&
              evaluation["puntos_obtenidos"] == null) {
            //return NoEvaluationPopup(product: product);
          } else {
            //return NotFoundPopup(barcode: data);
          }
        });

    _barcodeCapture.isEnabled = canScan;
  }

  @override
  void didUpdateSession(
      BarcodeCapture barcodeCapture, BarcodeCaptureSession session) {}

  @override
  void dispose() {
    _ambiguate(WidgetsBinding.instance)?.removeObserver(this);
    _barcodeCapture.removeListener(this);
    _barcodeCapture.isEnabled = false;
    _camera?.switchToDesiredState(FrameSourceState.off);
    _context.removeAllModes();
    try {
      super.dispose();
    } catch (error) {}
  }

  T? _ambiguate<T>(T? value) => value;
}
