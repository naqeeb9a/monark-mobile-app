import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

class ApiData {
  getInfo(query) async {
    try {
      var url = Uri.https('smac.cmcmtech.com', 'api/$query');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonResponse = convert.jsonDecode(response.body);
        return jsonResponse["data"];
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
