// Types pour les résultats d'authentification
abstract class AuthFailure {
  final String message;
  final int? statusCode;
  
  const AuthFailure(this.message, {this.statusCode});
}

class ServerFailure extends AuthFailure {
  const ServerFailure(super.message, {super.statusCode});
}

class NetworkFailure extends AuthFailure {
  const NetworkFailure(super.message, {super.statusCode});
}

class ValidationFailure extends AuthFailure {
  const ValidationFailure(super.message, {super.statusCode});
}

class AuthenticationFailure extends AuthFailure {
  const AuthenticationFailure(super.message, {super.statusCode});
}

class UnknownFailure extends AuthFailure {
  const UnknownFailure(super.message, {super.statusCode});
}