import 'dart:convert';

import 'package:http/http.dart' as http;

class Products {
  var url = "https://fakestoreapi.com/products/";

  loadProductsFromApi() async {
    var response = await http.get(Uri.parse(url));
    print(json.decode(response.body).toString());
    return json.decode(response.body);
  }
}
