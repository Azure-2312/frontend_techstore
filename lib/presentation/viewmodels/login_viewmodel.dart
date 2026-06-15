// lib/presentation/viewmodels/login_viewmodel.dart

import 'package:flutter/foundation.dart';
import '../../domain/repositories/auth_repository.dart';
import 'login_state.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;

  LoginState _state = const LoginState();
  LoginState get state => _state;

  LoginViewModel(this._authRepository);

  void setUsername(String value) {
    _state = _state.copyWith(username: value, status: LoginStatus.initial);
    notifyListeners();
  }

  void setPassword(String value) {
    _state = _state.copyWith(password: value, status: LoginStatus.initial);
    notifyListeners();
  }

  Future<void> login() async {
    if (_state.username.trim().isEmpty || _state.password.isEmpty) {
      _state = _state.copyWith(
        status: LoginStatus.failure,
        errorMessage: 'Ingrese usuario y contraseña.',
      );
      notifyListeners();
      return;
    }

    _state = _state.copyWith(status: LoginStatus.loading);
    notifyListeners();

    try {
      final ok = await _authRepository.login(
        _state.username.trim(),
        _state.password,
      );
      _state = ok
          ? _state.copyWith(status: LoginStatus.success)
          : _state.copyWith(
              status: LoginStatus.failure,
              errorMessage: 'Credenciales incorrectas.',
            );
    } catch (_) {
      _state = _state.copyWith(
        status: LoginStatus.error,
        errorMessage: 'Error de conexión. Verifique el servidor.',
      );
    }

    notifyListeners();
  }

  void reset() {
    _state = const LoginState();
    notifyListeners();
  }
}
