import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:fashion_hub/app/constants/api_endpoints.dart';
import 'package:fashion_hub/core/network/dio_error_interceptor.dart';

class ApiService {
  final Dio _dio;

  Dio get dio => _dio;

  ApiService(this._dio) {
    _dio
      ..options.baseUrl = ApiEndpoints.baseUrl
      ..options.connectTimeout = ApiEndpoints.connectionTimeout
      ..options.receiveTimeout = ApiEndpoints.receiveTimeout
      ..interceptors.add(DioErrorInterceptor())
      ..interceptors.add(PrettyDioLogger(
          requestHeader: true, requestBody: true, responseHeader: true))
      ..options.headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      };
  }

  Future<Map<String, dynamic>?> loginUser(
      String email, String password) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.loginUser,
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        return response
            .data['user']; // Assuming the API returns user info.
      }
    } catch (e) {
      rethrow; // Propagate error for further handling.
    }
    return null; // Return null if login fails.
  }
}
