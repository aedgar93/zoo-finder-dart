import 'dart:async';

import 'package:http/http.dart' as http;

const baseUrl = "http://localhost:5000/api";

class API {
  static Future getAnimals() {
    var url = baseUrl + "/animals";
    return http.get(url);
  }
}
