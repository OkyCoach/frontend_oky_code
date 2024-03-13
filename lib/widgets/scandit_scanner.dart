import 'package:flutter/material.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:scandit_flutter_datacapture_barcode/scandit_flutter_datacapture_barcode.dart';
import 'package:scandit_flutter_datacapture_barcode/scandit_flutter_datacapture_barcode_capture.dart';
import 'package:scandit_flutter_datacapture_core/scandit_flutter_datacapture_core.dart';
import 'package:frontend_oky_code/widgets/product_popup.dart';
import 'package:frontend_oky_code/widgets/picture_popup.dart';
import 'package:frontend_oky_code/widgets/not_found_popup.dart';
import 'package:frontend_oky_code/helpers/fetch_data.dart';

import 'package:frontend_oky_code/widgets/v2_product_detail.dart';
import 'package:frontend_oky_code/widgets/product_detail.dart';


const String licenseKey =
    'AY2kjw2vKdeYNGj2WDrztPNDU60tRR0h+n/tF2wmxabHbkEZ+Wqom49UXfKXED7ieU3KIVwPjJ7OXXIWmGuhfpxBSjCBKuOvUA0gIgUlBY9fCe4YSCf4S9bvzqRwqVi2NNJc7Uo6ANoGT9sxbQkdd9m8ZBRWcvVUnZq6DUaJts/qgk3DyWIwYyeXTEYJzOgWPUAPtXYNBX9UvCDOufERM9yjWuhNP1jQhG0LfDEk+kaUWkfwF63E5G0c0epGGhot1QhYHfsY0bJ6j3qHnXtyncWqyPlUwaHMaxowuyeD9Qrwe2432JELn3t0mDGmWoxJU1kWJicWSkobDP+cfHGM9HSM8m1+WovhLRphGDYQBd5sYKKEYBIuPfpgB4/vZto7B9lWNlKIKpSw1yyCn0YtsWpJfCMvO43Lw/E84wbssQVuBas6tooZKOCEDY7O5ITL2PthlMKvCmEAMWVWD5bFZn4BcZN3vdW9GWzK6f7AwTmdvjBp0iCX7sydufJf35GG0mHkdIBbKCh6VgYYsqLb+XcKH0k4gLNrwyQZmpQuJTX9dj956XrAshKX66BJ7IKndam/2TkAB2uYq637EXGzXzYZuzoHBjeuQbO78qKDvQPGHWHJh8D3qMHNRp/tQcdt1f5mvBxRgnxUFvAK1UH0EasaJVdsyooOLpiFxSgZqYxRbRU0OZ9QT+pLpat+MC/hDnMhFsWHkwnLgL0F599qepI57QKWUmT8qvMdfg1p86iXv26ydjwJlccfnKWcQRjlpvJJ99vpU3SaEAD6G7fJPUkb+VB/ihfg';

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
    _barcodeCapture.isEnabled = false;
    var code = session.newlyRecognizedBarcodes.first;
    var data = (code.data == null || code.data?.isEmpty == true)
        ? code.rawData
        : code.data;
    var product = await fetchBarcodeData(data);
    var evaluation = await fetchEvaluationData(data);
    await showDialog(
        barrierColor: Colors.white.withOpacity(0),
        context: context,
        builder: (_) => (product["barcode"] != null && evaluation["puntos_obtenidos"] != null)
            ? ProductDetail(product: product, evaluation: evaluation,)
            : NotFoundPopup(barcode: data));
    _barcodeCapture.isEnabled = true;
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
