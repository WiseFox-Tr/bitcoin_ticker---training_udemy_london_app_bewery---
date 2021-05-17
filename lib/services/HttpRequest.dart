
import 'dart:convert';

import 'package:http/http.dart' as http;

class HttpRequest {

  static dynamic httpRequestGet(Uri url) async {
    http.Response response = await http.get(url);
    var data = response.body;

    if(response.statusCode == 200 && data != null) {
      print('status code : ${response.statusCode} -> data retrieved : $data');
      return jsonDecode(data);
    } else {
      throw Exception('failed to retrieve data : response code : ${response.statusCode}');
    }
  }
}
