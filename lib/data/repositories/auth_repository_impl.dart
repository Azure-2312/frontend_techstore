// lib/data/repositories/auth_repository_impl.dart

import '../../domain/repositories/auth_repository.dart';
import '../datasources/api_service.dart';
import '../../core/constants.dart';

class AuthRepositoryImpl implements AuthRepository {
  final ApiService _api;

  AuthRepositoryImpl(this._api);

  @override
  Future<bool> login(String username, String password) async {
    final response = await _api.post(
      AppConstants.loginEndpoint,
      {'username': username, 'password': password},
    );
    return response['ok'] == true;
  }
}
