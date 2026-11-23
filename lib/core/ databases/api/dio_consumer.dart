
import 'package:dio/dio.dart';

import 'api_consumer.dart';

class DioConsumer implements ApiConsumer {
  final Dio dio;

  DioConsumer({
    required this.dio,
    required String baseUrl,
  }) {
    dio.options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      contentType: Headers.jsonContentType,
    );
  }

  @override
  Future<dynamic> get(
      String path, {
        Map<String, dynamic>? queryParameters,
      }) async {
    final response = await dio.get(
      path,
      queryParameters: queryParameters,
    );

    return response.data;
  }

  @override
  Future<dynamic> post(
      String path, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
      }) async {
    final response = await dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
    );

    return response.data;
  }

  @override
  Future<dynamic> patch(
      String path, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
      }) async {
    final response = await dio.patch(
      path,
      data: data,
      queryParameters: queryParameters,
    );

    return response.data;
  }

  @override
  Future<dynamic> delete(
      String path, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
      }) async {
    final response = await dio.delete(
      path,
      data: data,
      queryParameters: queryParameters,
    );

    return response.data;
  }
}

