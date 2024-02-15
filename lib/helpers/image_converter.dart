import 'dart:io';
import 'dart:convert';


Future<String> convertImageToBase64(String imagePath) async {
  try {

    File imageFile = File(imagePath);
    
    final bytes = imageFile.readAsBytesSync();
    String img64 = base64Encode(bytes);

    return img64;
  } catch (e) {
      print('EL ERROR ES: $e');
    return "";
  }
}
