import 'package:bloc/core/abstract/usecases.dart';
import 'package:dartz/dartz.dart';
import 'package:bloc/domain/entities/user.dart';
import 'package:bloc/core/failure/auth_failure.dart';
import 'package:bloc/domain/repositories/auth_repository.dart';

class RegisterParams {
  final String name;
  final String email;
  final String password;
  final String? phone;

  RegisterParams({
    required this.name,
    required this.email,
    required this.password,
    this.phone,
  });
}

class RegisterUseCase implements UseCase<User, RegisterParams> {
  final AuthRepository _repository;

  RegisterUseCase(this._repository);

  @override
  Future<Either<AuthFailure, User>> call(RegisterParams params) {
    return _repository.register(
      name: params.name,
      email: params.email,
      password: params.password,
      phone: params.phone,
    );
  }
}