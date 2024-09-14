import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:frontend_oky_code/helpers/image_converter.dart';
import 'package:frontend_oky_code/helpers/auth_manager.dart';
import 'package:posthog_flutter/posthog_flutter.dart';

Future<Map<String, dynamic>> fetchBarcodeData(String? code, bool isScan) async {
  const url =
      'https://5bc1g1a22j.execute-api.us-east-1.amazonaws.com/qa/info_producto/';
  try {
    AuthManager authManager = AuthManager();
    Map<String, String> sessionData = await authManager.getSession();
    Map<String, dynamic> userInfo =
        sessionData.isNotEmpty ? jsonDecode(sessionData['userInfo']!) : {};
    String userId = userInfo.containsKey("sub") ? userInfo["sub"] : "";
    if(isScan) {
      Posthog().capture(
        eventName: 'fetchBarcodeData',
        properties: {
          'code': code!,
          'userId': userId,
        },
      );
    } else {
      Posthog().capture(
        eventName: 'previouslyScannedProduct',
        properties: {
          'code': code!,
          'userId': userId,
        },
      );
    }
    final response = await http
        .get(Uri.parse(
            '$url$code${userId.isNotEmpty ? '?user_id=$userId' : ''}&isScan=$isScan'))
        .timeout(const Duration(seconds: 5));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data;
    } else {
      return {"error": "Error en la solicitud HTTP"};
    }
  } on TimeoutException catch (_) {
    return {"timeout": "La solicitud ha tardado demasiado tiempo en responder"};
  } catch (error) {
    return {"error": "Ocurrió un error al buscar los datos"};
  }
}

Future<Map<String, dynamic>> fetchEvaluationData(String? code) async {
  const url =
      'https://5bc1g1a22j.execute-api.us-east-1.amazonaws.com/qa/algoritmo/';
  try {
    final response = await http
        .get(Uri.parse('$url$code'))
        .timeout(const Duration(seconds: 5));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data;
    } else {
      return {"error": "Error en la solicitud HTTP"};
    }
  } on TimeoutException catch (_) {
    return {"timeout": "La solicitud ha tardado demasiado tiempo en responder"};
  } catch (error) {
    return {"error": "Ocurrió un error al buscar los datos"};
  }
}

Future<List<dynamic>> fetchRecommendedProducts(String? code) async {
  const url =
      'https://5bc1g1a22j.execute-api.us-east-1.amazonaws.com/qa/recomendacion/';
  try {
    AuthManager authManager = AuthManager();
    Map<String, String> sessionData = await authManager.getSession();
    Map<String, dynamic> userInfo =
    sessionData.isNotEmpty ? jsonDecode(sessionData['userInfo']!) : {};
    String userId = userInfo.containsKey("sub") ? userInfo["sub"] : "";
    final response = await http.get(Uri.parse('$url$code${userId.isNotEmpty ? '?user_id=$userId' : ''}'));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data;

    } else {
      return [
        {"error": "Error: Error en la solicitud HTTP"}
      ];
    }
  } catch (error) {
    return [
      {"error": "Error: Ocurrió un error al buscar los datos"}
    ];
  }
}

Future<String> uploadImage(String imagePath, String? filename) async {
  const url =
      'https://5bc1g1a22j.execute-api.us-east-1.amazonaws.com/dev/subir_imagen';

  try {
    String base64Image = await convertImageToBase64(imagePath);
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json', // Especifica el tipo de contenido
      },
      body: jsonEncode({'base64Image': base64Image, 'filename': filename}),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data["imageUrl"];
    } else {
      return "Error en la solicitud HTTP: ${response.statusCode}";
    }
  } catch (error) {
    return "Error al buscar los datos: $error";
  }
}

Future<String> requestProduct(String barcode, String name, String brand,
    String frontImageUrl, String backImageUrl) async {
  const url =
      'https://5bc1g1a22j.execute-api.us-east-1.amazonaws.com/dev/solicitar_producto';

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json', // Especifica el tipo de contenido
      },
      body: jsonEncode({
        'barcode': barcode,
        'name': name,
        'brand': brand,
        'url_img_front': frontImageUrl,
        'url_img_back': backImageUrl
      }),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data["message"];
    } else {
      return "Error en la solicitud HTTP: ${response.statusCode}";
    }
  } catch (error) {
    return "Error al buscar los datos: $error";
  }
}

Future<String> notifyMissingProduct(String? barcode) async {
  const url =
      'https://5bc1g1a22j.execute-api.us-east-1.amazonaws.com/dev/solicitar_producto';

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json', // Especifica el tipo de contenido
      },
      body: jsonEncode({
        'barcode': barcode,
      }),
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data["message"];
    } else {
      return "Error en la solicitud HTTP: ${response.statusCode}";
    }
  } catch (error) {
    return "Error al buscar los datos: $error";
  }
}

Future<String> likeProduct(String productId, bool removeLike) async {
  try {
    AuthManager authManager = AuthManager();
    Map<String, String> sessionData = await authManager.getSession();
    Map<String, dynamic> userInfo = jsonDecode(sessionData['userInfo']!);
    String userId = userInfo["sub"];

    var url =
        'https://5bc1g1a22j.execute-api.us-east-1.amazonaws.com/qa/like/product/$productId?user_id=$userId&remove_like=$removeLike';

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data["message"];
    } else {
      return "Error en la solicitud HTTP: ${response.statusCode}";
    }
  } catch (error) {
    return "Error al buscar los datos: $error";
  }
}

Future<String> likeOkytip(
    String productId, String okytipId, bool removeLike) async {
  try {
    AuthManager authManager = AuthManager();
    Map<String, String> sessionData = await authManager.getSession();
    Map<String, dynamic> userInfo = jsonDecode(sessionData['userInfo']!);
    String userId = userInfo["sub"];

    var url =
        'https://5bc1g1a22j.execute-api.us-east-1.amazonaws.com/qa/like/oky_tip/$productId?oky_tip_id=$okytipId&user_id=$userId&remove_like=$removeLike';

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      return data["message"];
    } else {
      return "Error en la solicitud HTTP: ${response.statusCode}";
    }
  } catch (error) {
    return "Error al buscar los datos: $error";
  }
}

Future<List<dynamic>> scannedProductsHistory() async {
  try {
    AuthManager authManager = AuthManager();
    Map<String, String> sessionData = await authManager.getSession();
    Map<String, dynamic> userInfo = jsonDecode(sessionData['userInfo']!);
    String userId = userInfo["sub"];

    var url =
        'https://5bc1g1a22j.execute-api.us-east-1.amazonaws.com/qa/product-history/$userId?limit=30';

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data as List;
    } else {
      return [];
    }
  } catch (error) {
    return [];
  }
}

Future<List<dynamic>> favoritesProducts() async {
  try {
    AuthManager authManager = AuthManager();
    Map<String, String> sessionData = await authManager.getSession();
    Map<String, dynamic> userInfo = jsonDecode(sessionData['userInfo']!);
    String userId = userInfo["sub"];
    var url =
        'https://5bc1g1a22j.execute-api.us-east-1.amazonaws.com/qa/all_product_like/$userId';

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data as List;
    } else {
      return [];
    }
  } catch (error) {
    return [];
  }
}

Future<List<dynamic>> searchProducts(String query) async {
  try {
    var url =
        'https://5bc1g1a22j.execute-api.us-east-1.amazonaws.com/qa/search?search=$query';

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);
      return data as List;
    } else {
      return [];
    }
  } catch (error) {
    return [];
  }
}
