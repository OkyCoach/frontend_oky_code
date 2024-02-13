import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Map<String, dynamic>> fetchBarcodeData(String? code) async {
  const url =
      'https://5bc1g1a22j.execute-api.us-east-1.amazonaws.com/dev/info_producto/';
  try {
    final response = await http.get(Uri.parse('$url$code'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data;
    } else {
      return {"error": "Error en la solicitud HTTP"};
    }
  } catch (error) {
    return {"error": "Ocurrió un error al buscar los datos"};
  }
}

Future<Map<String, dynamic>> fetchEvaluationData(String? code) async {
  const url =
      'https://5bc1g1a22j.execute-api.us-east-1.amazonaws.com/dev/algoritmo/';
  try {
    final response = await http.get(Uri.parse('$url$code'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data;
    } else {
      return {"error": "Error en la solicitud HTTP"};
    }
  } catch (error) {
    return {"error": "Ocurrió un error al buscar los datos"};
  }
}

Future<List<Map<String, dynamic>>> fetchRecommendedProducts(String? code) async {
  const url =
      'https://5bc1g1a22j.execute-api.us-east-1.amazonaws.com/dev/recomendacion/';
  try {
    final response = await http.get(Uri.parse('$url$code'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      List<Future<Map<String, dynamic>>> futures = [];

      for (var recommendedCode in data) {
        futures.add(Future.wait([
          fetchBarcodeData(recommendedCode),
          fetchEvaluationData(recommendedCode),
        ]).then((List<dynamic> results) {
          return {
            'product_info': results[0],
            'evaluation': results[1],
          };
        }));
      }

      var recommendedProducts = await Future.wait(futures);
      return recommendedProducts;
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
