import 'package:bloc/core/failure/auth_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:bloc/domain/entities/user.dart';


abstract class AuthRepository {

  Future<Either<AuthFailure, User>> login({
    required String email,
    required String password,
  });

  Future<Either<AuthFailure, User>> register({
    required String name,
    required String email,
    required String password,
    String? phone,
  });

  Future<Either<AuthFailure, bool>> logout();

  Future<Either<AuthFailure, User>> refreshToken({
    required String refreshToken,
  });

  Future<Either<AuthFailure, User>> getCurrentUser();

  Future<Either<AuthFailure, bool>> forgotPassword({
    required String email,
  });

  Future<Either<AuthFailure, bool>> resetPassword({
    required String token,
    required String newPassword,
    required String confirmPassword,
  });

  Future<Either<AuthFailure, bool>> verifyEmail({
    required String email,
    required String verificationCode,
  });

  Future<Either<AuthFailure, bool>> resendVerificationCode({
    required String email,
  });

  Future<Either<AuthFailure, bool>> isLoggedIn();

  Future<Either<AuthFailure, bool>> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  });

  Future<Either<AuthFailure, User>> updateProfile({
    String? name,
    String? email,
    String? phone,
  });

  Future<Either<AuthFailure, bool>> deleteAccount({
    required String password,
  });

  Future<Either<AuthFailure, String?>> getStoredToken();

  Future<Either<AuthFailure, bool>> saveToken(String token);

  Future<Either<AuthFailure, bool>> clearStoredToken();

  Future<Either<AuthFailure, User?>> getStoredUser();

  Future<Either<AuthFailure, bool>> saveUser(User user);

  Future<Either<AuthFailure, bool>> clearStoredUser();
}