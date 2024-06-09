// api_service.dart

import 'package:dio/dio.dart';
import 'package:task_manager_app/core/utils/auth.dart';
import 'package:task_manager_app/core/utils/endpoints.dart';

class ApiService {
  Dio dio;
  ApiService({required this.dio}) {
    dio.options.baseUrl = Endpoints.BASE_URL;
    dio.options.headers = {"Authorization": "Bearer ${Auth.TOKEN}"};
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        return handler.next(options); // continue
      },
      onResponse: (response, handler) {
        return handler.next(response); // continue
      },
      onError: (DioException e, handler) {
        return handler.next(e); // continue
      },
    ));
  }

  Future<dynamic> get(String endpoint) async {
    print("================================================");
    print("GET : $endpoint");
    print("================================================");

    try {
      final response = await dio.get(endpoint);
      return _handleResponse(response);
    } on DioException catch (e) {
      throw _handleError(e);
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Future<dynamic> post(String endpoint, Map<String, dynamic> data) async {
    print("================================================");
    print("POST : $endpoint");
    print(data);
    print("================================================");
    try {
      final response = await dio.post(endpoint, data: data);
      return _handleResponse(response);
    } on DioException catch (e) {
      throw _handleError(e);
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Future<dynamic> put(String endpoint, Map<String, dynamic> data) async {
    print("================================================");
    print("PUT : $endpoint");
    print(data);
    print("================================================");
    try {
      final response = await dio.put(endpoint, data: data);
      return _handleResponse(response);
    } on DioException catch (e) {
      throw _handleError(e);
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Future<dynamic> delete(String endpoint) async {
    print("================================================");
    print("DELETE : $endpoint");
    print("================================================");
    try {
      final response = await dio.delete(endpoint);
      return _handleResponse(response);
    } on DioException catch (e) {
      throw _handleError(e);
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  dynamic _handleResponse(Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
      case 204:
        return response.data;
      case 400:
        throw Exception('Bad Request: ${response.data}');
      case 401:
        throw Exception('Unauthorized: ${response.data}');
      case 403:
        throw Exception('Forbidden: ${response.data}');
      case 404:
        throw Exception('Not Found: ${response.data}');
      case 500:
      default:
        throw Exception('Server Error: ${response.data}');
    }
  }

  Exception _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.cancel:
        return Exception('Request to API server was cancelled');
      case DioExceptionType.connectionTimeout:
        return Exception('Connection timeout with API server');
      case DioExceptionType.unknown:
        if (error.error == 'No Internet connection') {
          return Exception('No Internet connection');
        }
        return Exception('Connection to API server failed due to internet connection');
      case DioExceptionType.receiveTimeout:
        return Exception('Receive timeout in connection with API server');
      case DioExceptionType.badResponse:
        return _handleResponse(error.response!);
      case DioExceptionType.sendTimeout:
        return Exception('Send timeout in connection with API server');
      case DioExceptionType.badCertificate:
        return Exception('Bad certificate');
      case DioExceptionType.connectionError:
        return Exception('Connection error');
      default:
        return Exception('Something went wrong');
    }
  }
}
