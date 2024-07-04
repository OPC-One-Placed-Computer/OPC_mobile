import 'package:dio/dio.dart';
import 'package:opc_mobile_development/app/app.locator.dart';

import 'package:opc_mobile_development/models/user.dart';
import 'package:opc_mobile_development/services/api/auth/auth_api_service.dart';
import 'package:opc_mobile_development/services/api/shared_preference/shared_preference_service.dart';
import 'package:opc_mobile_development/services/helpers/dio_client.dart';

class AuthServiceImpl implements AuthApiService {
  AuthServiceImpl({Dio? dio}) : _dio = dio ?? DioClient().instance;

  final Dio _dio;
  final _sharedPrefService = locator<SharedPreferenceService>();

  @override
  Future<bool> registerUser(User user, String password) async {
    try {
      return await _dio
          .post('/register',
              data: user.toJson()
                ..addEntries({
                  'password': password,
                  'password_confirmation': password
                }.entries))
          .then((result) {
        if (result.statusCode != null && result.statusCode == 200) {
          return true;
        } else {
          return false;
        }
      });
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<User> loginUser(String email, String password) async {
    try {
      final response = await _dio.post('/login',
          queryParameters: {'email': email, 'password': password});
      if (response.statusCode != null && response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        final user = User.fromJson(data['data']).copyWith(token: data['token']);

        await _sharedPrefService.setUser(user);
        await _sharedPrefService.setToken(data['token']);

        return user;
      } else {
        throw Exception(response.statusMessage);
      }
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<bool> logout(User user) async {
    try {
      final response = await _dio.post('/logout', data: user.toJson());
      if (response.statusCode != null && response.statusCode == 200) {
        await _sharedPrefService.removeUser();
        await _sharedPrefService.removeToken();
        return true;
      } else {
        throw Exception(response.statusMessage);
      }
    } catch (_) {
      rethrow;
    }
  }

 
 
}
