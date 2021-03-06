import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class NetworkHandler

{
  String baseurl ="http://10.0.2.2:8080/";
  var log = Logger();
  Future get(String url) async {
    url =formater(url);
    //user registre
    var response = await http.get(url);
    if(response.statusCode == 200 || response.statusCode == 201){
      log.i(response.body);
      return json.decode(response.body);
    }

    log.i(response.body);
    log.i(response.statusCode);
    return response;

  }

  Future<http.Response> post(String url,Map<String,String>body)async{

    url =formater(url);
    var response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(body));
    if(response.statusCode == 200 || response.statusCode == 201){
      log.i(response.body);
    }
    log.i(response.body);
    log.i(response.statusCode);
    return response;


  }
  Future getUser(String url,String token) async {
    url =formater(url);
    log.i(url);
   String basicAuth = "Bearer "+token;
    var response = await http.get(url,
        headers: {'authorization': basicAuth});
    if(response.statusCode == 200 || response.statusCode == 201){
      log.i(response.body);
      return json.decode(response.body);
    }



  }

  String formater (String url){
    return baseurl+url;
  }
}