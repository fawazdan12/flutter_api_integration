import 'package:bloc/domain/usecases/register_login.dart';
import 'package:flutter/material.dart';
import 'package:bloc/domain/entities/user.dart';
import 'package:bloc/core/failure/auth_failure.dart';
import 'package:bloc/domain/usecases/login_usecase.dart';
import 'package:dartz/dartz.dart';

class AuthProvider with ChangeNotifier {
  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;

  User? _user;
  bool _isLoading = false;
  String? _errorMessage;

  AuthProvider({
    required LoginUseCase loginUseCase,
    required RegisterUseCase registerUseCase,
  }) : _loginUseCase = loginUseCase,
       _registerUseCase = registerUseCase;

  User? get user => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _user != null;

  /// Connexion
  Future<void> login(String email, String password) async {
    _setLoading(true);

    final Either<AuthFailure, User> result = await _loginUseCase(
      LoginParams(email: email, password: password),
    );

    result.fold(
      (failure) {
        _errorMessage = failure.message;
        _user = null;
      },
      (user) {
        _errorMessage = null;
        _user = user;
      },
    );

    _setLoading(false);
  }

  /// Inscription
  Future<void> register(
    String name,
    String email,
    String password, {
    String? phone,
  }) async {
    _setLoading(true);

    final Either<AuthFailure, User> result = await _registerUseCase(
      RegisterParams(
        name: name,
        email: email,
        password: password,
        phone: phone,
      ),
    );

    result.fold(
      (failure) {
        _errorMessage = failure.message;
        _user = null;
      },
      (user) {
        _errorMessage = null;
        _user = user;
      },
    );

    _setLoading(false);
  }

  void logout() {
    _user = null;
    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
