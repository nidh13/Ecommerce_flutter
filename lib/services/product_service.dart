import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ProductService {
  Future getProducts() async {
    //najlaaa
    var url = 'http://10.0.2.2:8080/api/products/getAll';
    //print(url);
    var searchResponse = await http.get(url);
    // print(searchResponse.body);
    //najla
    if (searchResponse.statusCode == 201) {
      //  print(searchResponse.body);
      var jsonResp = json.decode(searchResponse.body);
      //  print("aaaaaaaaaaaaaaaa");
      //  print(jsonResp.toString());
      if (jsonResp["success"] == true && jsonResp["data"].length > 0) {
        //   print(jsonResp["data"].toString());
        ///jsonResp["data"].sublist(1, 3);
        /////najla
        return jsonResp["data"];
      } else
        return [];
    } else
      return [];
  }

  Future getProductsByCat(String categoryId) async {
    //najlaa
    var url = 'http://10.0.2.2:8080/api/products/getAllByIdCategory/' +
        categoryId;
    print("urlllllllllllllll");
    print(url);
    var productByCat = await http.get(url);
    print("productByCat.body");
    print(productByCat);
    //najla
    if (productByCat.statusCode == 201) {
      print("productByCat.body");
      print(productByCat.body);
      var jsonproductByCat = json.decode(productByCat.body);
      print("aaaaaaaaaaaaaaaa");
      print(jsonproductByCat.toString());
      //najla
      if (jsonproductByCat != null) {
        print(jsonproductByCat.toString());

        ///jsonResp["data"].sublist(1, 3);
        return jsonproductByCat;
      } else
        return [];
    } else
      return [];
  }

  Future getProductByDetails(String productId) async {
    //najla
    var url = 'http://10.0.2.2:8080/api/products/getByIdWithDetais/' +
        productId;
    print("urlllllllllllllll");
    print(url);
    var productByDetaills = await http.get(url);
    print("productByDetaills.body");
    print(productByDetaills);
    //najla
    if (productByDetaills.statusCode == 201) {
      print("productByDetaills.body");
      print(productByDetaills.body);
      var jsonproductByDetails = json.decode(productByDetaills.body);
      print("aaaaaaaaaaaaaaaa");
      print(jsonproductByDetails.toString());
      if (jsonproductByDetails["success"] == true &&
          jsonproductByDetails["data"].length > 0) {
        print(jsonproductByDetails.toString());
        return jsonproductByDetails["data"];
      } else
        return [];
    } else
      return [];
  }
}

