import 'package:http_interceptor/http_interceptor.dart';

class TokenAuthInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    print("interceptRequest is called");
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async {
      print("interceptResponse is called");
      return data;
  }

}