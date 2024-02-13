import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:frontend_oky_code/pages/add_product/image_preview.dart';

class NutritionalImageCapture extends StatefulWidget {
  final dynamic data;

  const NutritionalImageCapture({Key? key, required this.data}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<NutritionalImageCapture> {
  late CameraController controller;
  late List<CameraDescription> _cameras;
  bool ready = false;

  @override
  void initState() {
    initializeCamera();
    super.initState();
  }

  Future<void> initializeCamera() async {
    _cameras = await availableCameras();

    controller = CameraController(_cameras[0], ResolutionPreset.max);
    await controller.initialize();

    if (mounted) {
      setState(() {
        ready = true;
      });
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _nextStep(BuildContext context, String picturePath) async {
    dynamic data = {
      'productName': widget.data['productName'],
      'brand': widget.data['brand'],
      'frontImagePath': widget.data['frontImagePath'],
      'type': "nutricional",
      'nutritionalImagePath': picturePath,
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
    if (!ready) {
      return Container();
    }
    return Stack(
      children: [
        CameraPreview(controller),
        TextButton(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
          ),
          onPressed: () async {
            XFile picture = await controller.takePicture();
            _nextStep(context, picture.path);
          },
          child: Text('TextButton'),
        )
      ],
    );
  }
}
