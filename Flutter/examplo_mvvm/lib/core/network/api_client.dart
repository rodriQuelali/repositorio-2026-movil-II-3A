import 'package:dio/dio.dart';
import '../constants/api_constants.dart';
import 'token_manager.dart';

class ApiClient {
  final Dio dio;
  final TokenManager _tokenManager = TokenManager();

  ApiClient()
      : dio = Dio(
          BaseOptions(
            baseUrl: ApiConstants.baseUrl,
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 10),
          ),
        ) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // 🔐 Aquí se inyecta el token en cada request.
          // JSONPlaceholder lo ignora, pero una API real lo validaría.
          final token = await _tokenManager.getToken();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (DioException error, handler) async {
          // 🔄 Manejo típico de token expirado (401)
          if (error.response?.statusCode == 401) {
            // Aquí llamarías a un endpoint de refresh token,
            // o forzarías logout y redirigirías al login.
            await _tokenManager.clearToken();
          }
          return handler.next(error);
        },
      ),
    );
  }
}