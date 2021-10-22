import 'dart:convert';

import 'package:http/http.dart' as http;

getShopifyCategory() async {
  var response = await http.get(Uri.parse(
      "https://32a2c56e6eeee31171cc4cb4349c2329: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@monark-clothings.myshopify.com/admin/api/2021-07/smart_collections.json"));
  var jsonData = jsonDecode(response.body);
  return jsonData["smart_collections"];
}

getShopifyProducts() async {
  var response = await http.get(Uri.parse(
      "https://32a2c56e6eeee31171cc4cb4349c2329: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@monark-clothings.myshopify.com/admin/api/2021-07/products.json"));
  var jsonData = jsonDecode(response.body);
  return jsonData["products"];
}

getPriceOfCollection(id) async {
  var response = await http.get(Uri.parse(
      "https://32a2c56e6eeee31171cc4cb4349c2329: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@monark-clothings.myshopify.com/admin/api/2021-07/products/$id.json"));
  var jsonData = jsonDecode(response.body);
  return [
    jsonData["product"]["variants"][0]["price"],
    jsonData["product"]["options"][0]["values"]
  ];
}

getShopifyCollection(id) async {
  var response = await http.get(Uri.parse(
      "https://32a2c56e6eeee31171cc4cb4349c2329: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@monark-clothings.myshopify.com/admin/api/2021-07/collections/$id/products.json"));
  var jsonData = jsonDecode(response.body);
  return jsonData["products"];
}
