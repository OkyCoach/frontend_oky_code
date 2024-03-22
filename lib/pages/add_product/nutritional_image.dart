import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:frontend_oky_code/pages/add_product/image_preview.dart';
import 'package:frontend_oky_code/pages/add_product/new_product_image_popup.dart';
import 'package:frontend_oky_code/widgets/permission_popup.dart';

class NutritionalImageCapture extends StatefulWidget {
  final dynamic data;

  const NutritionalImageCapture({Key? key, required this.data})
      : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<NutritionalImageCapture> {
  late CameraController controller;
  late List<CameraDescription> _cameras;
  bool ready = false;
  bool isPopupVisible = true;

  @override
  void initState() {
    initializeCamera();
    super.initState();
  }

  Future<void> initializeCamera() async {
    _cameras = await availableCameras();
    controller = CameraController(_cameras[0], ResolutionPreset.max);

    try {
      await controller.initialize();
      setState(() {
        ready = true;
      });
    } catch (e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            _showAlert();
            break;
          case 'AudioAccessDenied':
            _showAlert();
            break;
          default:
            _showAlert();
            break;
        }
      }
    }
  }

  void _showAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const PermissionDialogWidget();
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void togglePopupVisibility() {
    setState(() {
      isPopupVisible = !isPopupVisible;
    });
  }

  void _nextStep(BuildContext context) async {
    XFile picture = await controller.takePicture();
    dynamic data = {
      'barcode': widget.data['barcode'],
      'productName': widget.data['productName'],
      'brand': widget.data['brand'],
      'frontImagePath': widget.data['frontImagePath'],
      'type': "nutricional",
      'nutritionalImagePath': picture.path,
    };

    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            ImagePreviewPage(data: data),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0); // starting offset from right
          const end = Offset.zero;
          const curve = Curves.easeInOutQuart;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          var offsetAnimation = animation.drive(tween);

          return SlideTransition(position: offsetAnimation, child: child);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    if (!ready) {
      return Container();
    }
    return Stack(
      alignment: Alignment.center,
      children: [
        FittedBox(
            fit: BoxFit.cover,
            child: SizedBox(
              width: screenWidth,
              height: screenHeight,
              child: CameraPreview(controller),
            )),
        if (isPopupVisible)
          NewProductImagePopup(
              onOkyPressed: togglePopupVisibility, type: "nutritional"),
        if (!isPopupVisible)
          Positioned(
            bottom: screenHeight * 0.07,
            child: GestureDetector(
              onTap: () {
                _nextStep(context);
              },
              child: Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withOpacity(0.65),
                    width: 3.0,
                  ),
                ),
                child: Center(
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.65),
                    ),
                  ),
                ),
              ),
            ),
          )
      ],
    );
  }
}
