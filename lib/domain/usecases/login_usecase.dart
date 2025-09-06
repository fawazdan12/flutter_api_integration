import 'package:bloc/core/abstract/usecases.dart';
import 'package:dartz/dartz.dart';
import 'package:bloc/domain/entities/user.dart';
import 'package:bloc/core/failure/auth_failure.dart';
import 'package:bloc/domain/repositories/auth_repository.dart';

class LoginParams {
  final String email;
  final String password;

  LoginParams({
    required this.email,
    required this.password,
  });
}

class LoginUseCase implements UseCase<User, LoginParams> {
  final AuthRepository _repository;

  LoginUseCase(this._repository);

  @override
  Future<Either<AuthFailure, User>> call(LoginParams params) {
    return _repository.login(
      email: params.email,
      password: params.password,
    );
  }
}