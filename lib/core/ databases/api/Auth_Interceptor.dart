import 'package:dio/dio.dart';

import '../cache/token_storage.dart';
import 'end_points.dart';

class AuthInterceptor extends Interceptor {
  final TokenStorage tokenStorage;

  AuthInterceptor({
    required this.tokenStorage,
  });

  static const publicPaths = {
    EndPoints.login,
    EndPoints.signup,
    EndPoints.forgotPassword,
    EndPoints.resetPassword,
  };

  @override
  void onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) async {
    try {
      final baseUri = Uri.parse(options.baseUrl);
      final requestUri = options.uri;

      if (baseUri.origin != requestUri.origin) {
        options.headers.removeWhere(
              (key, value) =>
          key.toLowerCase() == 'authorization',
        );

        handler.next(options);
        return;
      }

      if (publicPaths.contains(requestUri.path)) {
        handler.next(options);
        return;
      }

      final token = await tokenStorage.getToken();

      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] =
        'Bearer $token';
      }

      handler.next(options);
    } catch (error) {
      handler.reject(
        DioException(
          requestOptions: options,
          error: error,
          message: 'Failed to prepare authentication request',
        ),
      );
    }
  }
}
