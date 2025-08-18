import 'package:bloc/data/models/user_model.dart';

class RegisterResponseModel {
  final String accessToken;
  final String tokenType;
  final UserModel user;

  RegisterResponseModel({
    required this.accessToken,
    required this.tokenType,
    required this.user,
  });

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    return RegisterResponseModel(
      accessToken: json['access_token'],
      tokenType: json['token_type'],
      user: UserModel.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'token_type': tokenType,
      'user': user.toJson(),
    };
  }
}
