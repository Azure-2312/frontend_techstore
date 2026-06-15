// lib/presentation/viewmodels/login_state.dart

enum LoginStatus { initial, loading, success, failure, error }

class LoginState {
  final LoginStatus status;
  final String username;
  final String password;
  final String? errorMessage;

  const LoginState({
    this.status       = LoginStatus.initial,
    this.username     = '',
    this.password     = '',
    this.errorMessage,
  });

  LoginState copyWith({
    LoginStatus? status,
    String?      username,
    String?      password,
    String?      errorMessage,
  }) {
    return LoginState(
      status:       status       ?? this.status,
      username:     username     ?? this.username,
      password:     password     ?? this.password,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
