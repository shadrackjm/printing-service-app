// get all services
import 'dart:convert';

import 'package:print_services_app/constant.dart';
import 'package:print_services_app/models/api_response.dart';
import 'package:print_services_app/models/services.dart';
import 'package:http/http.dart' as http;
import 'package:print_services_app/services/user_service.dart';

Future<ApiResponse> getServices() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(
      Uri.parse(serviceURL),
      headers: {'Accept': 'application.json', 'Authorization': 'Bearer $token'},
    );
    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['services']
            .map((p) => ServiceProvided.fromJson(p))
            .toList();
        apiResponse.data as List<dynamic>;
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
