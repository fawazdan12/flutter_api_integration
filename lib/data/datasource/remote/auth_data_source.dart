import 'package:bloc/data/models/register_response_model.dart';
import 'package:dio/dio.dart';

// Exception personnalisée pour les erreurs d'authentification
class AuthException implements Exception {
  final String message;
  final int? statusCode;
  
  AuthException(this.message, {this.statusCode});
  
  @override
  String toString() => 'AuthException: $message';
}

class AuthDataSource {
  final Dio _dio;
  final String baseUrl;

  AuthDataSource({
    Dio? dio,
    this.baseUrl = 'https://your-api-base-url.com/api',
  }) : _dio = dio ?? Dio() {
    _configureDio();
  }

  void _configureDio() {
    _dio.options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      sendTimeout: const Duration(seconds: 15),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    // Intercepteur pour les logs (optionnel, utile pour le debug)
    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      logPrint: (object) => print(object),
    ));
  }

  /// Connexion utilisateur
  Future<AuthResponse> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        '/auth/login',
        data: {
          'email': email,
          'password': password,
        },
      );


      return AuthResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioException(e);
    } catch (e) {
      throw AuthException('Erreur inattendue: $e');
    }
  }

  /// Inscription utilisateur
  Future<AuthResponse> register({
    required String name,
    required String email,
    required String password,
    String? phone,
  }) async {
    try {
      final response = await _dio.post(
        '/auth/register',
        data: {
          'name': name,
          'email': email,
          'password': password,
          if (phone != null) 'phone': phone,
        },
      );

      return AuthResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioException(e);
    } catch (e) {
      throw AuthException('Erreur inattendue: $e');
    }
  }

  /// Déconnexion utilisateur
  Future<AuthResponse> logout(String token) async {
    try {
      final response = await _dio.post(
        '/auth/logout',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      return AuthResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioException(e);
    } catch (e) {
      throw AuthException('Erreur inattendue: $e');
    }
  }

  /// Actualiser le token
  Future<AuthResponse> refreshToken(String refreshToken) async {
    try {
      final response = await _dio.post(
        '/auth/refresh',
        data: {
          'refresh_token': refreshToken,
        },
      );

      return AuthResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioException(e);
    } catch (e) {
      throw AuthException('Erreur inattendue: $e');
    }
  }

  /// Récupérer les informations de l'utilisateur connecté
  Future<AuthResponse> getCurrentUser(String token) async {
    try {
      final response = await _dio.get(
        '/auth/me',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      return AuthResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioException(e);
    } catch (e) {
      throw AuthException('Erreur inattendue: $e');
    }
  }

  /// Réinitialisation du mot de passe
  Future<AuthResponse> forgotPassword(String email) async {
    try {
      final response = await _dio.post(
        '/auth/forgot-password',
        data: {
          'email': email,
        },
      );

      return AuthResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioException(e);
    } catch (e) {
      throw AuthException('Erreur inattendue: $e');
    }
  }

  /// Réinitialiser le mot de passe avec un token
  Future<AuthResponse> resetPassword({
    required String token,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      final response = await _dio.post(
        '/auth/reset-password',
        data: {
          'token': token,
          'password': newPassword,
          'password_confirmation': confirmPassword,
        },
      );

      return AuthResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioException(e);
    } catch (e) {
      throw AuthException('Erreur inattendue: $e');
    }
  }

  /// Vérifier l'email
  Future<AuthResponse> verifyEmail({
    required String email,
    required String verificationCode,
  }) async {
    try {
      final response = await _dio.post(
        '/auth/verify-email',
        data: {
          'email': email,
          'verification_code': verificationCode,
        },
      );

      return AuthResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioException(e);
    } catch (e) {
      throw AuthException('Erreur inattendue: $e');
    }
  }

  /// Renvoyer le code de vérification
  Future<AuthResponse> resendVerificationCode(String email) async {
    try {
      final response = await _dio.post(
        '/auth/resend-verification',
        data: {
          'email': email,
        },
      );

      return AuthResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioException(e);
    } catch (e) {
      throw AuthException('Erreur inattendue: $e');
    }
  }

  /// Gestion centralisée des erreurs Dio
  AuthException _handleDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return AuthException('Délai de connexion dépassé', statusCode: null);
      
      case DioExceptionType.sendTimeout:
        return AuthException('Délai d\'envoi dépassé', statusCode: null);
      
      case DioExceptionType.receiveTimeout:
        return AuthException('Délai de réception dépassé', statusCode: null);
      
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        final message = e.response?.data?['message'] ?? 'Erreur du serveur';
        return AuthException(message, statusCode: statusCode);
      
      case DioExceptionType.cancel:
        return AuthException('Requête annulée', statusCode: null);
      
      case DioExceptionType.connectionError:
        return AuthException('Erreur de connexion réseau', statusCode: null);
      
      default:
        return AuthException('Erreur de requête: ${e.message}', statusCode: null);
    }
  }

  /// Méthode utilitaire pour définir le token d'autorisation
  void setAuthToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  /// Méthode utilitaire pour supprimer le token d'autorisation
  void clearAuthToken() {
    _dio.options.headers.remove('Authorization');
  }
}