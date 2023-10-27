import 'dart:convert';

import 'package:print_services_app/constant.dart';
import 'package:print_services_app/models/api_response.dart';
import 'package:print_services_app/models/orders.dart';
import 'package:print_services_app/services/user_service.dart';
import 'package:http/http.dart' as http;

Future<ApiResponse> makeOrder() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(
      Uri.parse(serviceURL),
      headers: {'Accept': 'application.json', 'Authorization': 'Bearer $token'},
    );
    switch (response.statusCode) {
      case 200:
        
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        apiResponse.error = somethingWentWrong;
    }
  } catch (e) {
    apiResponse.error = '$e';
  }
  return apiResponse;
}
