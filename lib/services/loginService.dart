import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tivele/URLS.dart';
import 'package:tivele/models/loginModel.dart';
class LoginService {
  static var client = http.Client();

  static Future fetchLogin(Map<String, Object> userData) async {
    var response=await client.post(Uri.parse(URLS.BASEURL+URLS.login),body: userData);
    final requestbody = json.decode(response.body);
    try {
      if(response.body.isNotEmpty){
        if(requestbody["status"]==100){
          return requestbody;
        }else if(requestbody["status"]==701){
          return requestbody;
        }else if(requestbody["status"]==702){
          return requestbody;
        }else{
          // var jsonString=response.body;
          // print(response.body);
          // return loginMFromJson(jsonString);
          return requestbody;
        }
      }
      else{
        return null;
      }
    }catch (e) {
      return null;
    }
  }
}
