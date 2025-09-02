import 'package:bloc/core/failure/auth_failure.dart';
import 'package:bloc/data/datasource/remote/auth_data_source.dart';
import 'package:bloc/domain/entities/user.dart';
import 'package:bloc/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource _authDataSource;

  AuthRepositoryImpl({
    required AuthDataSource authDataSource,
  }) : _authDataSource = authDataSource;

  @override
  Future<Either<AuthFailure, User>> login({
    required String email, 
    required String password
  }) async {
    try {
      final response = await _authDataSource.login(
        email: email,
        password: password,
      );

      if (response.success && response.hasUser) {
        final user = response.getUserEntity();
        if (user != null) {
          // Optionnel : sauvegarder le token si présent
          if (response.hasToken) {
            _authDataSource.setAuthToken(response.token!);
          }
          return Right(user);
        } else {
          return Left(ServerFailure(
            'Données utilisateur invalides reçues du serveur'
          ));
        }
      } else {
        return Left(AuthenticationFailure(response.message));
      }
    } on AuthException catch (e) {
      return Left(_mapAuthExceptionToFailure(e));
    } catch (e) {
      return Left(UnknownFailure('Erreur inattendue lors de la connexion: $e'));
    }
  }

  @override
  Future<Either<AuthFailure, User>> register({
    required String name,
    required String email,
    required String password,
    String? phone,
  }) async {
    try {
      final response = await _authDataSource.register(
        name: name,
        email: email,
        password: password,
        phone: phone,
      );

      if (response.success && response.hasUser) {
        final user = response.getUserEntity();
        if (user != null) {
          // Optionnel : sauvegarder le token si présent
          if (response.hasToken) {
            _authDataSource.setAuthToken(response.token!);
          }
          return Right(user);
        } else {
          return Left(ServerFailure(
            'Données utilisateur invalides reçues du serveur'
          ));
        }
      } else {
        return Left(ValidationFailure(response.message));
      }
    } on AuthException catch (e) {
      return Left(_mapAuthExceptionToFailure(e));
    } catch (e) {
      return Left(UnknownFailure('Erreur inattendue lors de l\'inscription: $e'));
    }
  }

  /// Mapper les AuthException vers les types d'échecs appropriés
  AuthFailure _mapAuthExceptionToFailure(AuthException exception) {
    final statusCode = exception.statusCode;
    
    if (statusCode != null) {
      switch (statusCode) {
        case 400:
          return ValidationFailure(exception.message, statusCode: statusCode);
        case 401:
        case 403:
          return AuthenticationFailure(exception.message, statusCode: statusCode);
        case 404:
          return AuthenticationFailure('Service non trouvé', statusCode: statusCode);
        case >= 500:
          return ServerFailure(exception.message, statusCode: statusCode);
        default:
          return UnknownFailure(exception.message, statusCode: statusCode);
      }
    }

    // Erreurs sans code de statut (réseau, timeout, etc.)
    if (exception.message.contains('connexion') || 
        exception.message.contains('réseau') ||
        exception.message.contains('timeout') ||
        exception.message.contains('délai')) {
      return NetworkFailure(exception.message);
    }

    return UnknownFailure(exception.message);
  }

  @override
  Future<Either<AuthFailure, bool>> changePassword({
    required String currentPassword, 
    required String newPassword, 
    required String confirmPassword
  }) {
    throw UnimplementedError();
  }

  @override
  Future<Either<AuthFailure, bool>> clearStoredToken() {
    throw UnimplementedError();
  }

  @override
  Future<Either<AuthFailure, bool>> clearStoredUser() {
    throw UnimplementedError();
  }

  @override
  Future<Either<AuthFailure, bool>> deleteAccount({required String password}) {
    throw UnimplementedError();
  }

  @override
  Future<Either<AuthFailure, bool>> forgotPassword({required String email}) {
    throw UnimplementedError();
  }

  @override
  Future<Either<AuthFailure, User>> getCurrentUser() {
    throw UnimplementedError();
  }

  @override
  Future<Either<AuthFailure, String?>> getStoredToken() {
    throw UnimplementedError();
  }

  @override
  Future<Either<AuthFailure, User?>> getStoredUser() {
    throw UnimplementedError();
  }

  @override
  Future<Either<AuthFailure, bool>> isLoggedIn() {
    throw UnimplementedError();
  }

  @override
  Future<Either<AuthFailure, bool>> logout() {
    throw UnimplementedError();
  }

  @override
  Future<Either<AuthFailure, User>> refreshToken({required String refreshToken}) {
    throw UnimplementedError();
  }

  @override
  Future<Either<AuthFailure, bool>> resendVerificationCode({required String email}) {
    throw UnimplementedError();
  }

  @override
  Future<Either<AuthFailure, bool>> resetPassword({
    required String token, 
    required String newPassword, 
    required String confirmPassword
  }) {
    throw UnimplementedError();
  }

  @override
  Future<Either<AuthFailure, bool>> saveToken(String token) {
    throw UnimplementedError();
  }

  @override
  Future<Either<AuthFailure, bool>> saveUser(User user) {
    throw UnimplementedError();
  }

  @override
  Future<Either<AuthFailure, User>> updateProfile({
    String? name, 
    String? email, 
    String? phone
  }) {
    throw UnimplementedError();
  }

  @override
  Future<Either<AuthFailure, bool>> verifyEmail({
    required String email, 
    required String verificationCode
  }) {
    throw UnimplementedError();
  }
}