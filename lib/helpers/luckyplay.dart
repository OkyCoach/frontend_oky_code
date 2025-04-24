import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:frontend_oky_code/helpers/auth_manager.dart';

Future<bool> checkUserOportunities(String barcode) async {
  try {
    AuthManager authManager = AuthManager();
    Map<String, String> sessionData = await authManager.getSession();
    Map<String, dynamic> userInfo = jsonDecode(sessionData['userInfo']!);
    String userId = userInfo["sub"];
    var url =
        'http://localhost:3000/producto/verificar?user_id=$userId&barcode=$barcode&marcaId=1';

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'x-api-key': '26c5d5b3-9d87-4b74-97b1-fda6e70c1c79',
      },
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data["puedeJugar"];
    } else {
      return false;
    }
  } catch (error) {
    return false;
  }
}