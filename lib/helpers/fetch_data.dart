import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Map<String, dynamic>> fetchBarcodeData(String? code) async {
    const url = 'https://5bc1g1a22j.execute-api.us-east-1.amazonaws.com/dev/info_producto/';
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
    const url = 'https://5bc1g1a22j.execute-api.us-east-1.amazonaws.com/dev/algoritmo/';
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