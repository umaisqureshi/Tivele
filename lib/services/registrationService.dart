import 'package:http/http.dart' as http;
import 'package:tivele/URLS.dart';
import 'package:tivele/models/checkApiResponseModel.dart';
class RegistrationService {
  static var client = http.Client();

  static Future fetchRegister(Map<String, Object> userData) async {
    print(userData);
    var response=await client.post(Uri.parse(URLS.BASEURL+URLS.registration),body: userData);

    try {
      if(response.body.isNotEmpty){
        var jsonString=response.body;
        print(response.body);
        return checkApiResponseMFromJson(jsonString);
      }
      else{
        return null;
      }
    }catch (e) {
    }
  }
}
