import 'dart:io';
import 'dart:convert';
import 'package:image/image.dart' as img;
import 'dart:ui' as ui;
import 'dart:typed_data';

Future<String> convertImageToBase64(String imagePath) async {
  File imageFile = File(imagePath); 

  try {
    final bytes = imageFile.readAsBytesSync();
    String img64 = base64Encode(bytes);
    return img64;
  } catch (e) {
    print('EL ERROR ES: $e');
    return "";
  } finally {
    if (imageFile.existsSync()) {
      imageFile.delete();
    }
  }
}

Future<String> rotateFile(String path, double angle) async {
  // Lee la imagen del archivo
  img.Image image = img.decodeImage(File(path).readAsBytesSync())!;

  // Rota la imagen
  img.Image rotatedImage = img.copyRotate(image, angle: angle.toInt());

  // Guarda la imagen rotada en un nuevo archivo temporal
  File rotatedFile = File(path.replaceAll('.jpg', '_rotated.jpg'));
  await rotatedFile.writeAsBytes(img.encodeJpg(rotatedImage));

  await File(path).delete();
  return rotatedFile.path;
}
