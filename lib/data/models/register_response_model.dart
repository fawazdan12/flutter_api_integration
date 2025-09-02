import 'package:bloc/domain/entities/user.dart';

import 'user_model.dart';

class AuthResponse {
  final bool success;
  final String message;
  final UserModel? user;
  final String? token;

  AuthResponse({
    required this.success,
    required this.message,
    this.user,
    this.token,
  });

  // Factory constructor pour créer un AuthResponse à partir de JSON
  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
      token: json['token'] as String?,
    );
  }

  // Méthode pour vérifier si la réponse contient un utilisateur
  bool get hasUser => user != null;

  // Méthode pour vérifier si la réponse contient un token
  bool get hasToken => token != null;

  // Méthode pour obtenir l'entité User (si elle existe)
  User? getUserEntity() {
    return user?.toEntity();
  }

  // Méthode pour convertir en JSON (utile pour les tests ou la sérialisation)
  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      if (user != null) 'user': user!.toJson(),
      if (token != null) 'token': token,
    };
  }

  // Méthode pour créer une copie avec des modifications
  AuthResponse copyWith({
    bool? success,
    String? message,
    UserModel? user,
    String? token,
  }) {
    return AuthResponse(
      success: success ?? this.success,
      message: message ?? this.message,
      user: user ?? this.user,
      token: token ?? this.token,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AuthResponse &&
        other.success == success &&
        other.message == message &&
        other.user == user &&
        other.token == token;
  }

  @override
  int get hashCode {
    return success.hashCode ^
        message.hashCode ^
        user.hashCode ^
        token.hashCode;
  }

  @override
  String toString() {
    return 'AuthResponse(success: $success, message: $message, user: $user, token: $token)';
  }
}