import 'dart:convert';

import 'package:http/http.dart' as http;

class Products2 {
  var url = "https://api.escuelajs.co/api/v1/products";

  loadProductsFromApi() async {
    var response = await http.get(Uri.parse(url));
    print(json.decode(response.body).toString());
    return json.decode(response.body);
  }
}
