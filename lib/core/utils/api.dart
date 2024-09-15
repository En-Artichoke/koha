import 'package:dio/dio.dart';

class ApiClient {
  final Dio _dio = Dio();
  final String baseUrl = 'https://koha.net/api/v1';
  final String apiKey =
      'qh6MhJtE6cQFIuZsrbNqV997J7dgOTiNTJCRKE0skKYpVEWqk9Vm99o21stLQ9ys';

  ApiClient() {
    _dio.options.baseUrl = baseUrl;
    _dio.options.headers = {'x-api-key': apiKey};
  }

  Future<Response> get(String endpoint,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      return await _dio.get(endpoint, queryParameters: queryParameters);
    } on DioException catch (e) {
      throw Exception('Failed to get data: ${e.message}');
    }
  }

  Future<Response> post(String endpoint, {dynamic data}) async {
    try {
      return await _dio.post(endpoint, data: data);
    } on DioException catch (e) {
      throw Exception('Failed to post data: ${e.message}');
    }
  }
}
