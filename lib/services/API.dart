import 'dart:async';

import 'package:http/http.dart' as http;

const baseUrl = "https://show-me-the-otters.herokuapp.com/api";

class API {
  static Future getAnimals() {
    var url = baseUrl + "/animals";
    return http.get(url);
  }
}
