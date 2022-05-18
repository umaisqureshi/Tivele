import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:tivele/service/api_data/api_endpoint.dart';
import 'package:tivele/service/api_data/api_service.dart';
import 'package:tivele/service/api_data/request_header.dart';
import 'package:tivele/service/api_data/request_response.dart';
import 'package:tivele/service/token_auth/client_with_interceptor.dart';
import 'package:tivele/models/product/product_file.dart';

class RulesService {
  static const String BASE_PATH = "services/app/rule";
  static const String GET_ALL_PATH = "getAllRules";


  static Future<dynamic> getAll() async {
    APIService.baseUrl = BASE_PATH;
    APIService.customPath = GET_ALL_PATH;

    final response = await APIService.getAll();

    return response;
  }

}