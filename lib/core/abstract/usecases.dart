import 'package:dartz/dartz.dart';
import 'package:bloc/core/failure/auth_failure.dart';


abstract class UseCase<Type, Params> {
  Future<Either<AuthFailure, Type>> call(Params params);
}