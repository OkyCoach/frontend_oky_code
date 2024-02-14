import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:frontend_oky_code/pages/add_product/image_preview.dart';
import 'package:frontend_oky_code/widgets/new_product_image_popup.dart';

class FrontImageCapture extends StatefulWidget {
  final dynamic data;

  const FrontImageCapture({Key? key, required this.data}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<FrontImageCapture> {
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
    print("######################################################");
    print("INICIANDO");
    print("######################################################");
    _cameras = await availableCameras();
    print("######################################################");
    print("CAMARAS BIEN");
    print("######################################################");
    controller = CameraController(_cameras[0], ResolutionPreset.medium);
    print("######################################################");
      print("CONTROLADOR BIEN PRIMEROOOOOOO");
      print("######################################################");
    try {
      print("######################################################");
      print("CONTROLADOR BIEN");
      print("######################################################");
      await controller.initialize();
      setState(() {
        ready = true;
      });
      
    } catch (e) {
      print("######################################################");
      print("ERROR ACA");
      print("######################################################");
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            print("######################################################");
            print("ERROR DE ACCESO");
            print("######################################################");
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    } 
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

  void _nextStep(BuildContext context, String picturePath) async {
    dynamic newData = {
      'barcode': widget.data['barcode'],
      'productName': widget.data['productName'],
      'brand': widget.data['brand'],
      'type': "frontal",
      'frontImagePath': picturePath,
    };

    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            ImagePreviewPage(data: newData),
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
              onOkyPressed: togglePopupVisibility, type: "frontal"),
        if (!isPopupVisible)
          Positioned(
            bottom: 10,
            child: GestureDetector(
              onTap: () async {
                XFile picture = await controller.takePicture();
                _nextStep(context, picture.path);
              },
              child: Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withOpacity(0.65),
                    width: 3.0,
                  ),
                ),
                child: Center(
                  child: Container(
                    height: 70,
                    width: 70,
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
